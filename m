Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792727397;
	b=sFenT1pPbAnR2gBPiOKc/i7ZpMqDN26XyjTb4RjQRMxbhvSPt+NoEpax7gs2cu0KjNJW
	 WVae6qa+yuxehILVgQ71MTbtzpK9ApbOeIiTTfY3vTXVmqBO3LDXE6w7kCIrASrw4WjO/
	 Jy+qHprW/68l2zzBvI54OIlRJ2D5nYMmd3oIOvjlbWdzRgNVzRrFAxap2EtKGzAnHheSS
	 kS5e8BNIXlWlqY7MqnMI/rKwi86vKRyCzzCFQ94jVDrwTcaDmr8dAqwE1w0UpW0ezCNOu
	 sZDKJ9aztdDAKqtoTmccsWknL3WYbTIYFeItmjbEisiPVbzspdPP9imd9q24UhDFvvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792727397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e8SruC8g2rwvdIhh7oEO3GCo3RXeoIg5jF9AOnzr/wQ=;
	b=VPRzVgxJH31SXAGsaxKq/nNDVllMUfGC2hoKNhOtTJeEYJ51nji5KRjkNbDYLRVYlzp7
	 ZHWeOgibrCCh8Eov09F8xOL8Dlhqb0n++2M6sZFbakUp8k0+cwEyXS0OVBKqQG4jgFwJC
	 XyJGOl3XorK0uMIM4JboXjfok2DZWi3HlN3+iLJCPJH2QpE3tyGmXZ6LlLkzKj3pcpI+E
	 stmaYrf6nUQLNE/A5j+cEIQWp+WzRTN0Ax2TAEExfGYqaZSLSSiOGTXg9PnLc1+aB4MqB
	 7mOmJlWrpCqLlWnqQVPCCj6AQybOgov09u4J63XvnAWWSzecU1ndBM+lf3+X4BTDH6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=kUhUBAl1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C185606A319
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 03:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C185606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=kUhUBAl1
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so2375475e9.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792727396; cv=none;
        d=google.com; s=arc-20260327;
        b=J0PGuEm2GV3QBOOKvFZ9FV2vQCr8vZl5XuVR2zMpIwSYZxmbX+6VKdEy7dgkP65K3q
         gURQtTLIx+IphyXym9n2WClBmc4OPVSRv6yzVYyL4RJC7wSoZcau3SSAjoO8xykvkGi2
         HXFkgx3D9IS+5mKDi2sT91rsIaTzLcBM8VS/WBvN3kudMvd+0XEgD+JGOD50dwJjiqBp
         8BPaqemC1VNIrj2K7+fCHr5/mKAdaVSTqYj4gTtek554TOtL4H+t8r09vde2dOHspoRP
         hu+aJUvJK41+ooj2ZpRyplKxUWQ7162oNeorfn9QKW0X1ymdFiIGpRMCBppTlunbjxVB
         1CJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e8SruC8g2rwvdIhh7oEO3GCo3RXeoIg5jF9AOnzr/wQ=;
        fh=LfgIn9z4rYbgpjrYRqdwon8xleYqOKH8WhPd2S2t2Hg=;
        b=HTzHCxhTbs8SheEtUZfMEDEDFbHbUSDLYubq+JYGBzWv6blXiEko/6yUYW05/bTkK6
         7V5VMS0dempDp1DJ9sSxr4lds0/Qtp2IWesIFXoO7slpiscB9QewbFyKGjUHVl6TSnDe
         LFO8nzn+ARQTj0K5ydxxOK6bGNpGVDA8/s2ZQVm3+TIfbtntWWbMV2SXegD5IUjJGwIF
         a86U/912ghtR+BGbCbJEpBRKrs0ToEeRX34V05hqNQ1QjCQSM3IBlmQSCvMnZWi1lYzB
         dn/1nYGhynl5gedQcK02MoQM4FGr23fb+vUu+n5cbEJsD+wOjlcqYaSeUyTnrVYfGC3k
         jvJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792727396; x=1793332196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e8SruC8g2rwvdIhh7oEO3GCo3RXeoIg5jF9AOnzr/wQ=;
        b=kUhUBAl1Vvw3Ri2qrtj30EgWNb2AOm+I5l61Dasl7j0wscaMsPGbxw00U4Sn1tsrGb
         eRqA8RBV6KhEiSfhhUK2mOvnc0ASpoajFIK3vHOwEC7RGSe1cqZX4TU+RMWQwksaUO0u
         a1wZBRNt0qpZcic+o8gJnWBzqQDoQTGpU292hhxTEWw/aX+yUWN4fRWayfZNWd2opNNu
         j/eBZw11f+6HvgGkAwP2nsL2O88Rpx0WyuMB4Yd3PxOA0dkAAe8yJA8JJ66CnUskw5uH
         k9lvM45sCFs4i66aRnG8z/eeND8+HyLBohO2Qs+OoMkxy+J9aVXYUOU0co8aFNOvvAGt
         ZzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792727396; x=1793332196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8SruC8g2rwvdIhh7oEO3GCo3RXeoIg5jF9AOnzr/wQ=;
        b=KaXTh//5x2AxRYV9IkzYVYlJLXL1ZsUv0U3NzCCJRj54p35lkK7/fMFb02X3rGBsMY
         3iF8rmUie3ts04tTIhmdusxura512nq199Ct771OdbNSJWhBu3pciinKtVOtEl2Gohk2
         wsoIsu5B9E/OlpDKhBb77b17tG8iP5tJo2nst2RBKXLx2OeImJ8NTbSHRyvGJaRXADbA
         g+Xna1KOvmIUp67doymWonqptvE0E/vVggwSfvr1LfJh4CHprlES7cAq+dVewNAaf+IR
         j6+higK8rCb6vpyJ8qBREF/HbcBM+hNgYrimJRijg9vzqMyeKVzRgzTF4sha/hVemVvE
         33Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxRoQtiMCmj+z4Odz73VklqmjGby6V81UpezIy1JsMZeur3RAGu7PwL+Q73dthwyHvhiro=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0f2939KSmI6GC6Xuw9ib6fmprZU/Q5qDNV1VLsYkLnQXs+bjy
	xqwFlT3pfYcP8geoqd7L3S7T94RtvAZsKe0rZ7LNYBiXJrlpVHotPczJ2Emtad/WwpGNfD7zYiB
	EbqFo7bDlxSlaxJCGoAlUjMslEvlbluDMr5RdzhsSqg==
X-Gm-Gg: AYBFou3e/+0Qv2IN7Vd9AR8hCMOYSlTRXr+9HAssdqtDkoimvR23We2dO9ti5WbGLXu
	inlWgH39B8aH1geXzA/zA9Zftdpm54XFpmKFv/LFOLCvo5qedtP2sOf3dymR8ZZgRYP+hrZzcWY
	WNtTY6MPtz9sCowmO0WHiTyOsNXc9yOaa0k6oFSwwBWEHtsQR90I27eKAzZDlvhE8OK7fD0ahzD
	jhzVUVsBdfbfWz8fcR11cwQawtdRPyUTNxyEI5UnyHlFyvrKAfVElpLCtW2BQU20azyD3hKY82g
	1kaDmJpvC3Dt92LsXm8FY/xGsJk5uM9IzgJQ2NcHgD7vN25pjRgl1nHl6KT/t7lzjqxWHB05jU2
	UVyJLdnKP1R105gGR8aRkfYUDkRvFI1PFD62Wg6G7uRseHjZMEhkvu0fpOemM1JHKZ53Jz/z2wV
	D3jTV7f58ul1iAdHLNAgauylRIKUDGWxpVVDSpaDD+d7uoHMSCaTtUv8A=
X-Received: by 2002:a05:600c:a45:b0:4a1:fae2:a8ab with SMTP id
 5b1f17b1804b1-4a211c78b0fmr14407705e9.3.1792727395607; Thu, 22 Oct 2026
 20:49:55 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAhSdy1zNA7Xn9Uv1fFTRJMuCP0Pd2xLQazzm2FedTo_DZwMCA@mail.gmail.com>
 <CABgObfaH4-Ud4VR=GC8giDmWGJWS-tvYSmPOs4TtWg2hm4ocqw@mail.gmail.com>
In-Reply-To: <CABgObfaH4-Ud4VR=GC8giDmWGJWS-tvYSmPOs4TtWg2hm4ocqw@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Oct 2026 09:19:44 +0530
X-Gm-Features: AclHuK-CvaYfVDOqEfQN7aLUZ5bdjR2uJDsmHLdPAvhCz9ZB6h-rXHKmpRHIUtw
Message-ID: <CAAhSdy15rF2Hj8Zph7n61tfW79iSPe8mvLpy+eQRcyvAC0TZCA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv changes for 7.4
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:36=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Thu, Oct 22, 2026 at 2:51=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > Hi Paolo,
> >
> > I was on vacation last week; hence, I am sending
> > the KVM RISC-V 7.4 PR a bit late. Apologies for
> > the inconvenience.
>
> The problem is not the PR, it's that *none* of these changes were in
> linux-next until yesterday.  This is not the first time that I notice
> this and remind you of it...
>
> These are 80% bugfixes or otherwise not new features (e.g. 3/4/5/6 in
> the list below would be fine even for -rcN), so I'll pull
> nevertheless. But *please* try to commit stuff as soon as it's ready!

I generally update riscv_kvm_next branch much earlier before
merge window but this time I missed. Going forward, I will ensure
riscv_kvm_next branch is updated sooner.

Thanks,
Anup


>
> Paolo
>
> >
> > We have the following KVM RISC-V changes for 7.4:
> > 1) Lazy V-extension enablement for KVM selftests
> > 2) Implement KVM_PRE_FAULT_MEMORY ioctl() and enable corresponding KVM =
selftests
> > 3) Show sepc/scause/stval CSRs in KVM selftests vcpu dump
> > 4) Use a raw lock for IMSIC wakeup state
> > 5) Reject vCPU creation after AIA initialization
> > 6) Updated next branch name in KVM/riscv MAINTAINERS entry
> > 7) Allow Zicclsm, Ziccamoa, Ziccif, Za64rs for KVM guest
> >
> > In addition to the above, we also have the following fixes
> > and minor improvements:
> > 1) Avoid redundant interrupt check for pending timers
> > 2) Fix build with vector support disabled
> > 3) Fix IPI delivery for out-of-order vcpu_id
> > 4) Replace imsic switch-case macros with range checks
>
