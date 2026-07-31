Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86A32B137
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476662; cv=pass; b=Fp1ahqxA2syE1LsOYvyuKp+02UmXBrfpnObT1gCj9EBWaSOt4N+y7/8is3eLisjYYHRMtDSqVLUTEqLEOcLTCRytnPMuDDpYaDxtIRDCnAfU9eINeEnjK9nvJ2K+NUVw+AtbLEa8sPguzS6x3Fn9bxJbOlNzcyzH6rrV4Snc5mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476662; c=relaxed/simple;
	bh=zWZgcW4lyFMbzuE/2ay3O9mzW/r4iAm+NagUMTo/AC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glRcq2nBufCxPRY2n4U5nwOljNIVlMpFrA8+cbqeo0vxnS+8IzZdHta6Ct6oPeWgVkykLP+u72f88AYVSYxaweONDY3Xyg7rJdoFEQKRs31NQuTTwwcH8VscmvKUinOACfAcSuFcz02tup9wlar6hFmUAo8oIyT0rzGYFS7MEHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=mVl14OOF; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="mVl14OOF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fd4531020so27446f8f.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476659; cv=none;
        d=google.com; s=arc-20260327;
        b=mX/xe//LWKDnD3nOEBWY/P4x5YZ0mpcCjRB/Ya1lf59FoAA5UNjcQ3vM6/oB8pacVI
         ILv0A3mDsUc8UkPenQS+hNnnUUn3mgT88uiwWmrBdpzN1UZfHMrT3bB/dkMM5WfXiIhb
         yVNyd1TfLlnaE+7QBsmJAo26zFOve4+4oTk6uyhbw6UN55E/MJmarKPTZeK44kXOv/7z
         kX6vhpQsUd6TZcAPfrUDB+0JzUM1I6qUeCtb++u9GIjwA4HTa9UgO62rmyDVfrzY+SsL
         p23OyGL6Hz+dJpd80oFJA5Cah87bLO/j5P/Y3m4lskG0pd+UNYKN/sf3xQwngQjaLjeV
         tmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyufRcDXkH7OGX3Tp/WXvppb4b1akynKEKRhP9itFK4=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=paXNTLqyFBcfgw4LpZUSHCz2pRIXIOSrylMsi0eIR+OC3GKGXmf7Fa4VxeVeULaQiG
         F7+obAyoAmr/zpamqBhkr7lIb6Rt/g4+/DWqwDRjNtmP1xbOY0H226S8+Q9xQiKizlna
         3Eiit8I9/t7IL6hrsFt5I6IJKoos0Z3laqii+hdWAn8GdEB3rLs4L2zfPfrCbnUrXYKk
         waUZGYtFfyveU+q1Qvo/lnnOQ0cZwFS6d6Sq62F/ztxGmQXqZ1jchc4/TLe8Y9uo3ePs
         GbQvPiF9QOuUsQdkYfEAzlY54yfeLbQPm45d4buyuveM75GibJmuA3lwlVEaGk5ILcQi
         QYiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785476659; x=1786081459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyufRcDXkH7OGX3Tp/WXvppb4b1akynKEKRhP9itFK4=;
        b=mVl14OOF+wbBneYF5bHOB+K1CnqjOrlrslfXFEwxiBHYir80C4dtafQJ3FQouzBkYz
         fQAIMEl/xNmngy0Yorp2Q2I7my4pasMPiE4I9siAz66YCyDGGfWQwI4b3tWGtiBfTrcB
         O5pRV+vyi1Bwb0qQyofINXH7AWXMzCPBdWRscEtoCHyRm1OCAtVT7Z9b4YsunO1i3LCC
         B4dvrnT7EuamO2i9MOENxB+uLQSg9ZYQduOzAeI+CmFUPNPAzOtOQBPF0zn2cS1wV0c7
         /WFa3gLIF1HMPuTd65Hm/FadrpSuuV0X/0Qjl3UKHNOwETIWCmS1WMr6DgeS8+8mAADt
         RtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476659; x=1786081459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyufRcDXkH7OGX3Tp/WXvppb4b1akynKEKRhP9itFK4=;
        b=FIoWNIHexA8IlvJDnU7USCJb5ppAzJMhMSDL+ZqUeAFJufQwUPAnof/y4glqElcm6U
         hUn1FiEO/8OEwD9lJnbJLXP3ugNmF1P/wfM7fhojZLW/dt66YHZZLH1WYALzETF8khs0
         IhGx6wQ0bD0p+nhKShDbXXwdtq/thI3WnidFZ+UqtOrfkirgdNPGeQqa7ASET5XfEWk1
         +sK8vzTgjd1vS8OtDQH14xbe0Ha00rkGCXIn1ISMtedMGp15ZApG9c/tI6NFDLlsvzuQ
         i+N0gQJrw/RxQGTiWbf0OCniTqsOwN03vyx8wRHnCLf1sI91fFgIsi02VrL6s42IznAO
         4YQQ==
X-Gm-Message-State: AOJu0YzTpll2MBT8UF5JFFNNIbkAX+VDg9NC2+b2VGyjhxdhvKUDFOJ4
	pKLbUld57JUdaAQABaPPNCRrlKEIUt7DyFEMNPS4eBOec9HQ0J+Q8ZQhwVCntfLIy3DGqNOhvi0
	TtI8uJfyWvu23wLiRtKs1nNrAe7sYL4C4ikayn7HjRg==
X-Gm-Gg: AR+sD12j4JXodHmRAnaR5JLvfQK8CkASMVPXv/8d8BwZHlhwsYPn1UfSL+whrJkN9Z9
	Yz4LBIkGGG2lhUXjfO+AGJYx5vPmitedK34Y1LzZJm4pR/mFY2VAXjM1bBD0C8kEbM/dsoTuCL5
	GYJqeJmbX6pD4vi2SUDPOgAFF6nT8cxZJaOAKVPzU3j0TLjaBAqZZ+rZHvQMXyK6QGLLYsiI/XV
	1bA4UPijK3EvjCMc6PpwGdq5KF+Vo6OYxPCOgfTfXjLCmxrJETDlP11FU4PebXJvelLvgeCrMRx
	kZM/DNqk4zEfa6f2imKh462pSlfy/umKzh3VJszLtlh65JBgmkMdpYs8PvtffjtGC18+zBbwrNn
	9Qr86k7gl44AyiwR+0dgtgFA/p+z4ivVuc5S2Zqw6vbsZpYV9YUFqqz8tViZqbKI=
X-Received: by 2002:a05:6000:2212:b0:47f:8e50:93e0 with SMTP id
 ffacd0b85a97d-47fd2b328efmr1580964f8f.39.1785476659463; Thu, 30 Jul 2026
 22:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn> <20260701120954.129873-4-wang.yechao255@zte.com.cn>
In-Reply-To: <20260701120954.129873-4-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 Jul 2026 11:14:08 +0530
X-Gm-Features: AUfX_myKDnYmDHijHAzG-jJrRvK3vmSuf-KnXv-nXgVsR5qZr7fmqUsH6abxvaI
Message-ID: <CAAhSdy27pUkVYiciMOp6RdcyzNvsEeOXGA5pW43C1oZJZR4W_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] RISC-V: KVM: Remove redundant TLB flush operations
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:41=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> The function kvm_arch_mmu_enable_log_dirty_pt_masked() is invoked from
> two distinct call paths:
>
> kvm_clear_dirty_log_protect()
>   kvm_arch_mmu_enable_log_dirty_pt_masked()
>
> kvm_vm_ioctl_reset_dirty_pages()
>   kvm_dirty_ring_reset()
>     kvm_reset_dirty_gfn()
>         kvm_arch_mmu_enable_log_dirty_pt_masked()
>
> In both scenarios, the caller already performs a remote TLB flush after
> dirty logging is enabled, so the TLB flush inside
> kvm_arch_mmu_enable_log_dirty_pt_masked() is unnecessary. Remove it.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/kvm/mmu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 363238efaedb4..056c0abe278af 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -162,14 +162,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct=
 kvm *kvm,
>         phys_addr_t start =3D (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>         phys_addr_t end =3D (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
> -       bool flush;
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>
> -       flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
> -       if (flush)
> -               kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
> -                                           (end - start) >> PAGE_SHIFT);
> +       kvm_riscv_gstage_wp_range(&gstage, start, end);

Please add comment here that remote TLB flush is not needed here
since callers of kvm_arch_mmu_enable_log_dirty_pt_masked() already
do it.

>  }
>
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)
> --
> 2.43.5
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup
