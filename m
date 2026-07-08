Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8333355F25;
	Wed,  8 Jul 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531899; cv=none; b=Z6fRcNpvUBOIv2NGbZ8DuiUlkw9OTE3Bq+ptN5bEI9jJ1UlMTtSwePKpZCtCVXSwMfqNFgFW5fZs9A+Z/zbJJXP5zkATodobtvdYd+BiND7ZvFZcMfvg8L80kDZOhApA4yVhc2Ddqbdbs4waU2Fnk0f9iAvA53I1vc+ql5izcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531899; c=relaxed/simple;
	bh=Isy1ilaG6+XIPZAP9Co9UDCXL4BnV1UwhsTaSF3s21U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KCkBPVdCJiqca+GsnX9EjXX1qxnpFf1DnASysBhsicXWIsaSLXraFNPQt8miPu+Zv8a+PEbdeROp3YvUBIEkEK9iMRji9jJIdpgcwglcRt32b0AF+IqkFkIh//x6NdMq/QK9Qk5Dzd7zmB+6PsEiv9fAIyayi4SM+M12cxFzW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pb8lU7ub; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pb8lU7ub"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D4DC40E0031;
	Wed,  8 Jul 2026 17:31:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WwUl9Cw5m7mo; Wed,  8 Jul 2026 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783531885; bh=pBjUkSBAhsOo8m31s6U+CiM8Fkr7Q7ACXfdV2SEADcI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Pb8lU7ubVVzLNCvyJrGh4LJdjmTCDSYrufIPEXb0FQB8Z94XXc6/ZWMlanjAyF9nr
	 yg+d04Lb0z064bhM5SMIZi5Qy3kS/6XI4CyI66FCF9OiNW9OlWOY+DXgJ+0tZgdKXV
	 AkCw+W02N7MsffV1alI5okFU9OoUzwGE274VwZww//bSrH5fN6vUWFfRyaDooAsRe6
	 lmc4h2u33fxDhlXRdbAjnw7FnqxAOi4PHm3gqvzcuYFtO3HgJ4IDZijuc0PzFNBKSh
	 5o+0N5UStoTdpw5JZhHvur/bvm4QbQoMlSqfHLskhhbgWDMFpSoV6Gwy3sexeXQSv2
	 AwdSvdfc+6ewYZ/qaF4PFVCeVqv9C44QOEgFge2MFJL4S9EJGKkyJoQdWTJHuKKmDL
	 WXxdWXYUGXmrohcm6ag9nMeNmMUNQaBlbQUEIgwH27kYuDlkFYKmMfMjknOjyxYTzu
	 r8NMptPHLNEo8Y0/RFnzOby8V3qUtCqGDeR5Zgm7FHTDqPrYDNoI8jrBI9+odOGuOx
	 kpctXsYPYSj/pkozTwrxMJH0lLDQY6f4so8BSgKnVEFMKMN5SGDdN+uXeP90PRUI9e
	 37qEsN0hB5gSr2hr8342xLFvQ1m+fCGTYbA3Xi+xAX6UEwIePAztt5N4DFoKMIAN5S
	 pLzYpm/kryvvEYCJ56sGeV8M=
Received: from ehlo.thunderbird.net (mobile-166-170-42-114.mycingular.net [166.170.42.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6895C40E02B1;
	Wed,  8 Jul 2026 17:31:18 +0000 (UTC)
Date: Wed, 08 Jul 2026 17:31:14 +0000
From: Borislav Petkov <bp@alien8.de>
To: Mark Brown <broonie@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 KVM <kvm@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Sean Christopherson <seanjc@google.com>
Subject: Re: linux-next: manual merge of the kvm tree with the tip tree
User-Agent: K-9 Mail for Android
In-Reply-To: <ak5lu6XQP6PPtQ6u@sirena.org.uk>
References: <ak5lu6XQP6PPtQ6u@sirena.org.uk>
Message-ID: <10427F2C-C53A-4F88-B8B4-6048D6061A03@alien8.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 8, 2026 2:59:07 PM UTC, Mark Brown <broonie@kernel=2Eorg> wrote:
>diff --cc arch/x86/kvm/x86=2Ec
>index 63daa4dfa23ad,0626e835e9eb7=2E=2E0000000000000
>--- a/arch/x86/kvm/x86=2Ec
>+++ b/arch/x86/kvm/x86=2Ec
>diff --git a/arch/x86/kvm/msrs=2Ec b/arch/x86/kvm/msrs=2Ec
>index c230b18d87e38=2E=2E861d04bfa63dd 100644
>--- a/arch/x86/kvm/msrs=2Ec
>+++ b/arch/x86/kvm/msrs=2Ec
>@@ -651,7 +651,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info)
> 	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
> 		kvm_mmu_reset_context(vcpu);
>=20
>-	if (!static_cpu_has(X86_FEATURE_XSAVES) &&
>+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) &&
> 	    (efer & EFER_SVME))
> 		kvm_hv_xsaves_xsavec_maybe_warn(vcpu);

Yap, LGTM=2E

Thx=2E

--=20
Small device=2E Typos and formatting crap
