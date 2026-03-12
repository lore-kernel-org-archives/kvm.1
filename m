Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA1349B0B
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296669; cv=none; b=VRHrwH3dGaVfDAdJBacnigbhuTslL7pc49KN36Fg/q6kdybs4MaFBC2flRgVm6aQHlnZ54cnTPxCh8LpLp3JWQi2/sLqQ6F1Z/FlIg2TWY2/SPxHNDSpLYvnqZdmBUpuDiTdbXzqMXIwXPlCQWXZ/lZsSt/d/PL2q5aGtr03VBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296669; c=relaxed/simple;
	bh=ZyrDLYHbQbVT6XbfE/EfP5sNiNFC0RdEbWLHSkAZi1A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcVvdsBh6oKCFE2t3WmhNgsft5LEeAtOEGjb+oWneV0iqKYHWFvXPpXaIvjp4zAcvuowZnfUXO6YYoQxQt4DeAb5uk3hwMK3eoRe1h2m69xWJ9FXeh8elN/M85E9fyCbSVcvWn/lmPV1pskJ870tbAFsbHDzvm6ASSpqrG80Axs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=H9AdOFSe; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="H9AdOFSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773296654; bh=6XSUe9/mrSQXimq5mGLj4L9DwEmb0ajM05SNRjvldbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H9AdOFSeAoL+7mavmhmTur9Ek/a+SCjKjk2Musk2ejlCexWO3HmMNos+JOAxMTE8H
	 nKOlmmXdrERZcrdNnFU94oOASBrG2y8/mbrak8IdtnbpvgmRUTJSzH4noEwnxjKK8o
	 VpTwdiaXGXE1t/UIXdVuGAdlijNlR6h232v+ld1k=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 60C18CB3; Thu, 12 Mar 2026 14:24:12 +0800
X-QQ-mid: xmsmtpt1773296652t3j13gv5u
Message-ID: <tencent_9779016A2C6421E864AAC950615F99851B0A@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLjRFRAC/5sEXEs5bErb72+B4inlUlzreUKtkMP0Qk7Agg8/0rqt
	 oqxXPcdvpKzL8Ejb3JZOGXuecHO6ZN+gR0bHSy/1yzot7is81V9HT3/PmAk4kobK5qkutGJucDe6
	 NI/aWzqNIDZ5J1ukiePoldMOqF3MfPSvteDs/PhMQIcXBFJyV8/4sm3pggR7q0JLhvTqxyNKg6v9
	 7bpDaZD36Np80LeFPCV1nozUgB+QD8sK85MAl02zK1tSlTW5mZfDkOuLaO9UDYcChBIWmPV2hjNX
	 OAm0ehA0E9zxUXV2t1wabZXPVv4ecwFcycpjB3LKJhD+Cmvvjh47+wqnYtcy6nE2stAun+7QB3V0
	 tD2yb711fxrhy2VjhMMT5mhHpLfSEy5xkjkIqWCfhYd+R0cgqMYIFETPTxs9JH7azDk7Xom9s52s
	 ux1YyJiSjhWUk0FAFJaGxbBSpSPJLsZPq4vjIB4hzFI9Eh4+KqONfOvT5lM0T5irNtXIOS20M+yN
	 wt7D28B6kF04wIwiBuvlgzlhuxun4nKvnBmqlKv8gS0AE5VZmf1OhNGN9qEHG81q+Gt7SJQ7Frm9
	 c77a02nfpv+D9OpioMRnewfbJ1aByhN+VZJKNBw4vVha/VMnjaXYGp9SqbDVAyFnlCOCEUfDmM99
	 b6h7OKdG7cwWByiM9W9u2b/fZqIJnLBqj/Y5n/vgISrIfQN2kQMTI/h0pzBQUlR7D8F7BNOqS7MO
	 7vGjf9NeMcOYd9SGv0WxFGussHKb74KhirtgNmXAeziirdOWLxjp0cx0mt79oaI0CCjxnFBPyd+6
	 5rfM7f9F50L/U5GLQ9HyEmBV2WdS2YpzsgNiZ44REIY6SZx06QEtgIeQrqP4wTM90GaWjDrpTtEs
	 YNQtb4vc6eTeiY+7+qgKWXKqqN+9v8eqbblSmi053TpGqX1KE2J9towV7GR76BDMmKUCVfUe70su
	 EkKnQ6refC2nHjNAlLk7JII4JTOX347C1/3I/xkDMIKJs3Utk8AT2+UuVSxVCxxnW8ZlVhdKaEvk
	 IjhXWwZuYGNgKODn8Y
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Date: Thu, 12 Mar 2026 14:24:11 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org,
	zhanghao <zhanghao1@kylinos.cn>
Subject: Re: [PATCH 3/3] KVM: x86: Use dynamic try count based on vCPU count
X-OQ-MSGID: <20260312062411.GA80397@zh-pc>
References: <20260215140402.24659-1-76824143@qq.com>
 <tencent_EAB2053E04BF4C7F996CEC61331C23154007@qq.com>
 <aZSVbjPhURBe1Rj0@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZSVbjPhURBe1Rj0@google.com>

On Tue, Feb 17, 2026, Sean Christopherson wrote:
> On Sun, Feb 15, 2026, 76824143@qq.com wrote:
> > From: zhanghao <zhanghao1@kylinos.cn>
> > 
> > Replace the fixed try count (3) with a dynamic calculation based
> > on the number of online vCPUs. This allows larger VMs to try more
> > candidates before giving up, while keeping small VMs efficient.
> > 
> > Formula: clamp(ilog2(nr_vcpus + 1), 3, 10)
> > - 4 vCPUs: try = 3
> > - 64 vCPUs: try = 6
> > - 256 vCPUs: try = 8
> 
> Why do larger VMs warrant more attempts though?  E.g. what are practical downsides
> of trying min(nr_vcpus - 1, 8) times?

Larger VMs need more attempts because with more vCPUs, the probability
of randomly selecting a "good" yield target decreases.

Consider this scenario:
    4 vCPUs: 1 lock holder + 3 waiters. Random pick has 33% chance of finding the holder.
    64 vCPUs: 1 lock holder + 63 waiters. Random pick has only 1.6% chance of finding the holder.
With 64 vCPUs, you need ~20x more attempts to have the same probability of success as with 4 vCPUS.

Given your feedback, I'm open to changing to the simpler formula:
    try = min(nr_vcpus - 1, 8);
The performance difference is minimal in practice, and code clarity is
valuable.

Best regards,
zhanghao

