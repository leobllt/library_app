exports.livroStatusChange = functions.firestore.document('Livros/{livroId}').onSnapshot((snapshot, context) => {
  const livroData = snapshot.data();
  const novoStatus = livroData.status;

  // Verificar se o status foi alterado
  if (livroData.statusAnterior !== novoStatus && novoStatus === 'disponível') {
    const livroId = snapshot.id;

  // Buscar e notificar usuários
  const querySnapshot = firestore.collection('usuarios');
  for (const documentSnapshot of querySnapshot.docs) {
    try{
      const usuarioDoc = documentSnapshot.data()
      const livrosReservados = usuarioDoc.get('reservados')
        if(livroId in livrosReservados){
          const usuarioData = usuarioDoc.data();
          const tokenDoDispositivo = usuarioData.tokenDispositivo; // Obter token do dispositivo

          // Enviar notificação para o usuário
          enviarNotificacao(livroId, tokenDoDispositivo);
        }
    }
    catch{
      console.error('Erro ao buscar usuário:', error);
    }
  }
}
},

function enviarNotificacao(livroId, tokenDoDispositivo) {
  const message = {
    notification: {
      title: 'Livro disponível!',
      body: 'O livro que você reservou está disponível.',
    },
    data: {
      livroId: livroId,
    },
  };

  admin.messaging().sendToDevice(tokenDoDispositivo, message)
    .then(function(response) {
      console.log('Notificação enviada com sucesso:', response);
    })
    .catch(function(error) {
      console.error('Falha ao enviar notificação:', error);
    });
},)
