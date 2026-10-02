Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5A3A7582;
	Fri,  2 Oct 2026 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919791; cv=none; b=kcxMlL06eL2bcQByu1PFrC0pgVLWg1DsIsAvc81zFJH7apLdKtirBHfexDZOC0DRUVEBLxOQTRhO1cFcU9TQfXnARTdrqHcnNibIg/tY1EUClrgT9L1aEeM9st6dY/cTQ8DYrPvz0RO8LBCogtLJ1LuLFYv8iWIWvOn0WSBN+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919791; c=relaxed/simple;
	bh=218i/mKu08HVDpkdrkVozTJr8cJLILa2dq1GNhWEbBM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4NJLnR9CjFV0ja1nfTFMyq1gJyQbAtHHGEh5Pwb/Q13WfyOnvQeZaTdL8Ws1869TuYUksrs4jENqE5d5+7jPVqhPuIwFQ3RfgDvOpMVRO587mSRtNBAQbbSufakfiThI9KM0ZBLP5SZdFXm8e5dbYarTr/CtERVAqtooy+eR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryzome.com; spf=pass smtp.mailfrom=ryzome.com; dkim=pass (2048-bit key) header.d=ryzome.com header.i=@ryzome.com header.b=JCPyWTNT; arc=none smtp.client-ip=185.70.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryzome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryzome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryzome.com header.i=@ryzome.com header.b="JCPyWTNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryzome.com;
	s=protonmail; t=1790919782; x=1791178982;
	bh=uB1YvURsy+J7ylyRi+jJb7v0uihLBCMe9Mk712RxLvU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JCPyWTNTN7Q2n53m37Ez7ao8yx1PZmMWwcXMVkRMp6pzQguLz3gEVEOAC2aFTGqdJ
	 0YB0nCi12BfYI17JL9kfGwb/fJuo31Xrw6bZhUIn48AkiZwpE9eTRmOD8fxaPQBfwb
	 rX2DZEU/k9y4OT/TO9M+wqEp3UOvb1Njg+nbZmExsoYMGqfMWhDJrbayDpuCTgup+Y
	 kCWcFrwvjPn8LADxoo+moBAuy5vAcDbGKBgIoJP7Y4G0UV2Gl6vCQLlOBb9l+Y2fjk
	 P7z12w7brOE5kLsiLXX4h1H+qMOAiR3yLrmEFav/AE9h5KC+M85N0D1xJMbVpoEQ9E
	 6+SzfyLeZNchw==
Date: Fri, 02 Oct 2026 05:42:54 +0000
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
From: Loc Nguyen <loc@ryzome.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: Request event processing for exception VM-Exits
Message-ID: <20261002053723.3275202-2-loc@ryzome.com>
In-Reply-To: <20261002053723.3275202-1-loc@ryzome.com>
References: <20261002053723.3275202-1-loc@ryzome.com>
Feedback-ID: 78153448:user:proton
X-Pm-Message-ID: 51ab78704083fc73bbf13b5966af8467592e0b26
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Request event processing whenever kvm_queue_exception_vmexit() queues an
exception VM-Exit.  Most callers reach the helper through
kvm_multiple_exception(), which already sets KVM_REQ_EVENT, but nested
asynchronous page faults call it directly.

Without another event request, vcpu_enter_guest() skips
kvm_check_and_inject_events() and re-enters L2.  A subsequent VM-Exit can
clear the pending exception while reconstructing vectoring state, losing
the synthetic #PF VM-Exit.  The APF reason remains PAGE_NOT_PRESENT and a
later regular #PF can consume the stale value.

Setting KVM_REQ_EVENT in the common helper ensures that L1 receives the
queued VM-Exit before KVM re-enters L2.

Fixes: 7709aba8f716 ("KVM: x86: Morph pending exceptions to pending VM-Exit=
s at queue time")
Cc: stable@vger.kernel.org
Signed-off-by: Loc Nguyen <loc@ryzome.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf3fcdfd8ad2..376341a1ba04 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -450,6 +450,8 @@ static void kvm_queue_exception_vmexit(struct kvm_vcpu =
*vcpu, unsigned int vecto
 {
 =09struct kvm_queued_exception *ex =3D &vcpu->arch.exception_vmexit;
=20
+=09kvm_make_request(KVM_REQ_EVENT, vcpu);
+
 =09ex->vector =3D vector;
 =09ex->injected =3D false;
 =09ex->pending =3D true;
--=20
2.43.0


