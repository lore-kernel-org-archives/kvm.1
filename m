Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009715A864
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610119; cv=none; b=aqClds37kZpCvHY5eRdiW3X3L8gqNThhzBCMEo/9sbfjzxMVtqJs7YgEQ30GCkiKMCRq4yZrb5z5LD365h2kifUIMbz26d/c105hJEAL5xiYNzwsptBUOzXdouoq3rpxU21wjy+bb9vh3WrOvPYl4e7eURPV25R+8ESKTGJ0OOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610119; c=relaxed/simple;
	bh=c6LsDDWHxl+IyeJwtRxPcY/p2JWwdDpKFKOdY0l8OZs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nCmViIXyEMdNXN9U1GewQEwo7V4CSTMrUpS4BLxRSUbv1Tlkm7+sAIfp6tFr/zA02aRaubQmjqoWjyuFM0fzJE06XIV4idfbEkn2MCjIQGDtzbwhFKo8OFaUaROU3wP8oMhUu+ytq0xn5r/SsaGchEle3WL9+056yWtR2Z/VlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matthewpenney.net; spf=pass smtp.mailfrom=matthewpenney.net; dkim=pass (2048-bit key) header.d=matthewpenney.net header.i=@matthewpenney.net header.b=Dz7WnsoX; arc=none smtp.client-ip=185.70.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matthewpenney.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthewpenney.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthewpenney.net header.i=@matthewpenney.net header.b="Dz7WnsoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
	s=protonmail; t=1775610106; x=1775869306;
	bh=c6LsDDWHxl+IyeJwtRxPcY/p2JWwdDpKFKOdY0l8OZs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Dz7WnsoX4a2myS53oVBkHio95IPDwV1Yw0jeRHkMQBx5aw9Sc6OkxksM0XC8xvc9s
	 oxCdojP0FNSABvQkhVQKLn39M4GHwysTzBO9NSaZL+yRu7/avEATUKnX++9+DV+c2k
	 K2uE/SueR87LNM5rx01ExczjsZSe6AJTB2MjCUemqEIZ8RrtUvsVNT5sNDm1h0uETr
	 o9Ia1xiRcIXArztkMPmZL4oqLasIyLAGRFZfnt4I6UsVdo7reIIZeBsJGsBNlvDiZX
	 t/F2Y4TS7uerxideg+MhvC/nvf5dnRhJdeDSe3Wcf+BZQUQDMarRG0Um05wpleETgS
	 +yQTrxyEbcp0A==
Date: Wed, 08 Apr 2026 01:01:42 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Samuel Tardieu <sam@rfc1149.net>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Collin L. Walling" <walling@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/8] tree-wide: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-1-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 0b93e9d6492d44ac673aedfdd8598211ff563d8e
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series replaces open-coded uses of g_source_remove() with
g_clear_handle_id() across the tree.

This is a more modern (GLib >=3D 2.56) approach than directly calling
g_source_remove().

g_clear_handle_id() simplifies cleanup of GSource IDs since it
checks the ID is valid, calls the cleanup function and zeros the ID.

This reduces boilerplate and avoids open-coded calls to
g_source_remove().

This series follows an earlier fix that removed a dangling GSource tag
and replaced an explicit call to g_source_remove() with
g_clear_handle_id().

No functional changes.

Link: https://gitlab.com/qemu-project/qemu/-/commit/34aad589019c8687fb3b19b=
a79d64d97071a7205

Signed-off-by: Matthew Penney <matt@matthewpenney.net>

