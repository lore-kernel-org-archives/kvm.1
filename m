Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D14305E1F
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295055; cv=none; b=cyX+kJuuu0rKUt6nagZrf6D9EXzVbYke10GccC3Vaoo1tvZYPgZQx+bWvPYsBo1YN8s5rSXPORzX96dpTsda3++jyxLP3zEVDl2facJdzNgcxGRhNy8weAg3W16POP1OOTGylSYldSq/PHvi+VGN+RuM92WE9OKNdLDqw1RCA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295055; c=relaxed/simple;
	bh=ZDG1GTaAXHZ17ShEFoWj1kmXYwcpPj9TIFrgslsOWrY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufRf0SakNRNV7ai9tG6yMbkjVcVUOVOi49LHfXVRYAGbuwHhqq1z6JZrFAtuSbOodMNeEcIO+orvlmmv3V87+BRVBXLuqq7AAGWTOkPdMpHlje2Ojrt1dP5GrT8ooV8TEApiMRvkoFc+Ou3HxUGQHu8zcrYGTIUGTmLsGbft6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Uhk2j3/c; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Uhk2j3/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773295048; bh=rXA59tRZDZJyMv5RiO/pY5WFjK4/0lBoDgGf8desDgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uhk2j3/cpr6QlK6SpQR7VV+kfMkBXq7AW0bZYQH4len3lUkQTcLiViwsXx9BcDfsT
	 7+TpS3xPBLKY+FWKp9smmOVUwCHuoo8jgPQ4YefdZFrn8SF/SlxTkzs8NRU+pSxzJK
	 oyubLo5aJC9F16g3CchfuskwIzF0qx2fVEodFpFE=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id E5A2F825; Thu, 12 Mar 2026 13:57:26 +0800
X-QQ-mid: xmsmtpt1773295046trfl79fa2
Message-ID: <tencent_AE2873502605DBDD4CD1E810F06C410F0105@qq.com>
X-QQ-XMAILINFO: OTIbW6R4UQxKXoePGFFJOeWi7aRuoEfk3Tc65Tj6gPtqocg4J1fW7DRcLlsnbe
	 kcN7N27/hSFxO2wqs4j72v3FdcfYq4OGmxuByktcA07l4kDbB/R2NCQfw6DwRVZZhvJhEyTBLIOC
	 y3sCEMsnHbsjTY1ESDZpdcgFtljPREqjr4RF//04SevfCzxVSVzrAdNsWTaPuf0tlIIwNmBcYviW
	 3+kM9hWjHLIxKUVR08JkEzyf8Qfn1DAZQD4TwIjGawMq1iVZXlZ9/kT2G/z441OMrTnn8DK6Q3cd
	 dzLPPvKKTFO+dHJV0Bvs5p6W+GzVpvc1Ne+MNAcwLDkQVHDWQb2PrS/7u/nctd8GksnnHEUPbwuM
	 SJEWG8QKA92Q7TerSujgtM7Ndoemy+NGOOj8jXVau882BwLzdQ8QnQbQqzsKGwt0SlcKlE+8Q0lQ
	 ToLM093n8qno0r6Y+WaXRjMwtfVr2Jsg5pqJY/cIzLo9/3JDlK40yUwL+rEpp5nifc5Z2qDJS8WA
	 SQQUmp1Sg0jywOh0UIx/zG1ZZr1SQz35MPjHUgLYivo6oT3IgnUaS/IZV6kDBxYtE2oyeqzVu5+L
	 tkHJHrcVDmgfHApZN95x2xuHG/ef6OSTRPvVTvvknUJ3HayRvdY6+RAijpSM90T1WajpQzBcGOGN
	 0kF4LkL9VKbAPDkLCHR86G4RWMANh7M92Rg0nlywLXbdPAzvB4s8pN+4+RACXGeDtYpGAhXXHiuW
	 S0Ob+esPEqMDqFZKdLsGxJ/MNBV9UagPw5hN0GAJ0mb/Ewv9R5HpZjekRGN1SN6rEciTUQmqxq9I
	 ARQ75t4LUZ5IgX5uzRpGPdEmQKiCwJ1iuiI6ztvdZTyVGwOb9yjnp381WkuqDQQ6VqXg7RnaUfdj
	 7LydY5Wfi1w3deMMQc9ph+ad1xf9d0XF021QjZvBgkm4zAme3j9IsWX+FugVAgzH6CZuSvU2SioO
	 rvE4SUJz6J11GEh8ZLt+Wmbp8Ni5mNab1skb/SUNjEbKTyzhGWinCoSdIznb6Z/UyKDvSCdCVvjs
	 qem11ZtTD2ybmNkslP
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
Date: Thu, 12 Mar 2026 13:57:26 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org,
	zhanghao <zhanghao1@kylinos.cn>
Subject: Re: [PATCH 2/3] KVM: x86: Skip IN_GUEST_MODE vCPUs in
 kvm_vcpu_on_spin main loop
X-OQ-MSGID: <20260312055726.GA77347@zh-pc>
References: <20260215140402.24659-1-76824143@qq.com>
 <tencent_A1CC0E76805991513AA0C982068255A6A306@qq.com>
 <aZSMFPgRO6s_fUQO@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZSMFPgRO6s_fUQO@google.com>

On Tue, Feb 17, 2026, Sean Christopherson wrote:
> On Sun, Feb 15, 2026, 76824143@qq.com wrote:
> > From: zhanghao <zhanghao1@kylinos.cn>
> > 
> > Add a check in the kvm_vcpu_on_spin() main loop to skip vCPUs
> > that are already running in guest mode.
> > 
> > Reduces unnecessary yield_to() calls and VM exits.
> > 
> > Signed-off-by: zhanghao <zhanghao1@kylinos.cn>
> > ---
> >  virt/kvm/kvm_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 476ecdb18bdd..663df3a121c8 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -4026,6 +4026,10 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
> >  		vcpu = xa_load(&kvm->vcpu_array, idx);
> >  		if (!READ_ONCE(vcpu->ready))
> >  			continue;
> > +
> > +		if (READ_ONCE(vcpu->mode) == IN_GUEST_MODE)
> > +			continue;
> 
> This should generally not happen, as vcpu->ready should only be true when a vCPU
> is scheduled out.  Although it does look like there's a race in kvm_vcpu_wake_up()
> where vcpu->ready could be left %true, e.g. if the task was delyed or preempted
> after __kvm_vcpu_wake_up(), before the "WRITE_ONCE(vcpu->ready, true)".  Not sure
> how best to handle that scenario.
> 
> > +
> >  		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
> >  			continue;
> >  
> > -- 
> > 2.39.2
> >

Thank you for reviewing this patch. As pointed out in the discussion,
this addresses a race condition where kvm_vcpu_wake_up() can set
"ready=true" while kvm_sched_in() is concurrently setting the vCPU to
running state. Without this check, we might attempt to yield to a vCPU
that is already running, which is futile.

I'd like to provide additional context on the two new checks in
kvm_vcpu_on_spin() and request your feedback on the implementation.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1bc1da66b4b0..20d56c0479c8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4007,6 +4007,23 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
                vcpu = xa_load(&kvm->vcpu_array, idx);
                if (!READ_ONCE(vcpu->ready))
                        continue;
+
+               /*
+                * kvm_vcpu_wake_up() can race with kvm_sched_in() and leave @ready
+                * true for a running vCPU.  Filter out vCPUs that are not currently
+                * scheduled out to avoid futile directed-yield attempts.
+                */
+               if (!READ_ONCE(vcpu->scheduled_out))
+                               continue;
+
+               /*
+                * Additionally, skip vCPUs that are currently in guest mode.
+                * A vCPU in IN_GUEST_MODE cannot be yielded to until it exits
+                * to host mode.
+                */
+               if (READ_ONCE(vcpu->mode) == IN_GUEST_MODE)
+                               continue;
+
               if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
                        continue;

The scheduled_out check address the race between kvm_vcpu_wake_up() and
kvm_sched_in(). The IN_GUEST_MODE check ensure we only yield to vCPUs
that can actually be scheduled.

The implementation has been tested with sysbench mutex
workload(16threads, 32vCPUs):
| Metric                      |   Before |   After | Improvement |
| :-------------------------- | -------: | ------: | :---------- |
| Directed-yield success rate |  0.0113% | 2.8169% |     249x    |
| Mutex latency (sysbench)    | 1,658 ms |  162 ms |   -90.2%    |
| Futile yield attempts       |   17,744 |      69 |   -99.6%    |

I'm happy to make any additional changes based on your suggestions.
Thank you for your time and guidance.

Best regards,
zhanghao

