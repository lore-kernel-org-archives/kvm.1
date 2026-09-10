Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057B3C061D
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029891; cv=pass; b=CLfM0JUxjmiKJKIuSFd4P/18oGsSyQktCrVBeJA7mdPP8pnkYnwTPS8WYm4/pUfNth76eNavsEBA3EjJf8MelIK9gPYWBq6oN91wRAzyo7KYVJT8JYqrbuU+rLgt2qKBu/CCaM95iOqzYZT3R+wAsLfV05a0vlHjdBPcfoSZ41I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029891; c=relaxed/simple;
	bh=2L4i5AeMVgZ8ZbU5eaRQAyD/0mMzF1qyndAZfksaAzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNd2cAc3iGG4/E0t3uUUqolFYWugN/4S4lYaZ6Z697zf14MFjMnNONAQfSArvpc6nB+kxsLVb/KL0vLboSxGj9WrXxfySeRqOQwIpBDjmPyG/t3BwiM+t7EJ6qWe731abiBfm3LGBp4CKaGErEXK+K2PesBzyAqpBQATTToIkDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=LGfFbAZ+; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="LGfFbAZ+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d05d51553so42826605e9.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 01:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789029887; cv=none;
        d=google.com; s=arc-20260327;
        b=Ovzv1ZzV25Ct77sf6X7gq4n1vvHytQvXouuMi5JxoxS+Tag1RmKzqpx40w/mgO72tU
         Mvx233nXFqkYgW3J/WTnYff2Nhob3UC+RKN6ewsqNi8ZJK1W9g7kHcZWAKt5caGDQ+aS
         DfgJEqSg8BNIK/5+9oFiLEnDf7AhjZd32BG/YZshh1D9xbwIvLEPUXxjeCzjdHOgLLwo
         WN7wDOznYQIKCY8xLEo6vThi6hxpIZ9IvWF/56ArEfpeDxjh9AFEVbWYmRiZgzwS5dr9
         I4gdLQ8NvAOnoMqX1y+7kIuuZGsrYCb5vcRj1CCIr+6XkrBm5nPJhTUWxjTcsPO2uoQZ
         Cryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scbEHeSfgSCcxK7Ny73Kn4g0gC7DW9iSvZ1f2Vwg208=;
        fh=01XrwQ0mrc9nay9LdD3xVj+5FwihtvOm7EskO/UX+L4=;
        b=LDvgMvzSJLdWNOK8LlI3Sv93cc0mdBsrMkPkf7MRpTr+qiJsKE7Dno+wtqGTk/s4+S
         8sS3SgQ/ODfa7QX0+NoZOIJ7YvfIWq+06zd4DsielpeIN6zXsfp9a3aB4g1rKe/XgFtQ
         l5or1guZpdtqHWn60CTknCfLlV8kC1OYQdDzNlrfxrgpLr4pMd8oNFcsFhz7/bFaSmxe
         GR5qJ3UjLlsRKp/iZ823BPRXQXqtwl6RwL6lkC2sWtCfIlt4M5KYlZMmUpSxZSEd2k1z
         l6Vz2V0tthSuEys3UToSWBZhBLftgpDZtC/L6jG2iM4Gh0R13FrqhopSCv1EM9BIzrda
         6X9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789029887; x=1789634687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=scbEHeSfgSCcxK7Ny73Kn4g0gC7DW9iSvZ1f2Vwg208=;
        b=LGfFbAZ+C4M4vmS0ouD6dDR8QuWuY8OfJWvxoyirrdZ37ynmROZ1tSFs//8SLoetpI
         plGxxh68Dq+w0UVkHDPq4Kl/kzQLDUQky/AzW3HTL4YXWkMiDMg6biLRY5D5Z+QjyPaT
         mDDx2Gm9SQU5IBoReB1KTPfgP+jkxbpAF2N3VZ7xPowWHGXbWs2feuiSOMFs81pmAsvd
         O81b6GC7xxdbOQiqz5wrsUvxyFmf4e8YyzgSTh+Q8WW7hdLkxRb4UweYKWRREp8lB02V
         ZckgyHMMpVgJy2ANgWDVYKzXRePlCiLZmaO5mCuhEID17ZTtzzsLV8zVqEazHyXwuFth
         ewgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029887; x=1789634687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scbEHeSfgSCcxK7Ny73Kn4g0gC7DW9iSvZ1f2Vwg208=;
        b=m2kxT/aFbzmTqqpZkRD+PtiVRarIbp35UMVJAeq9uVBPxq+AME7l+IOxv9e8DsgsOa
         ggAPxEDbyaiuQduj40celDDkQKbRCVqVu/nn3XLPjoedio9zcRT6cT/lwTATVxEqvZKA
         1aoiJ2l0OZ6ud4cjGhXiFeNEEU+S6cIiE+hrdvdc6Ax4o2YzMJXZjk38lzs3LUrQ7Ix+
         Y7cBAkPgTN9Zd+yX9naK4GW0y8ovREZISIkNLahBzwuo8LrCwP7yz2opOjZOtJ/r2jiQ
         AU3QhkGOgevSXod2tLJ+YxcY+pBlqV8GiwsBoporgyyiqtij5LnGwLf/ITEwxXUyYIc/
         ZsKg==
X-Forwarded-Encrypted: i=1; AKwUvBxK8MT5pEvpdLxQmLlv9Q4EUT9pqNgtzCxFZw2trtcM++zitTt4EBUy/2IhgIoInFMUTXs=@vger.kernel.org
X-Gm-Message-State: AFuF++loahRyD+NoCq5mPCOoopnTBhBDXB5hvqIVq9NFFhtv5SAqLnih
	LObe8MIZOOQvIoh3q/VKVMKyPeXKBtcwaUA+8ojS4IUn5UyzCKIogZOBYQFRQ2ad3jREJJqqQjD
	kjIIkh6oqheTKE6Er+a+BbCMp+82Xjrn9GFW34k2BNg==
X-Gm-Gg: AYBFou1b2tY2gs4liW2I00tDThASimLEFWMVgOQ/7ta7Pr4D7Cd/GtAkI9drRNuAxux
	EPsTxUhVA7fB3JRh3ZbAtMXr8j3CKaNcxySz9XjZTlbNPhXf0YNUZKtd1Z8GSKOmI8up7RqRc5L
	PkySKnbA9zKCtvnZeQYR+QsvJbltPnpbtsIC19D4J5UiG7whdIK89MXNwfJl1KdK5MWSlrPjzhO
	3wDfeBIdr0kNRcdozKTUNk0j05ki8lLPXlozsReniUSLxMY8Epol0/1/R1DoH+Dm/6chMjEaOaa
	K12m1KbEO2jaWRQEEHIm05Naxb8NyYcu1tNhABXbT8ixhVBkENxh1L+LfOTUETCO+XXrIZJBATL
	ff3Kn8QrPjbxTCX3ilP5sLsH5VuaNQishRkjVW4TUgRIyctSRgrHblbPCnzT4pUGcj5zvTLHb27
	k=
X-Received: by 2002:a05:600c:3148:b0:49d:1e3d:3b3f with SMTP id
 5b1f17b1804b1-49d1e3d3b56mr116962455e9.8.1789029886716; Thu, 10 Sep 2026
 01:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
 <20260731163550.46991-1-mhun512@gmail.com>
In-Reply-To: <20260731163550.46991-1-mhun512@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 14:14:34 +0530
X-Gm-Features: AcwNN1V28fjgBOHn1dVY71XHW4M_hQYvtSbbXwHks3Yz0rwxCZGQBzSs1WPsOfE
Message-ID: <CAAhSdy27Ou5CJ8CaKE+QdnK_n+rq9nBJHWOu2V02DvUDQFXWcg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Synchronize hrtimer callback during teardown
To: Myeonghun Pak <mhun512@gmail.com>
Cc: atish.patra@linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:05=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> =
wrote:
>
> The non-Sstc hrtimer callback clears next_set before its final uses of
> the enclosing vCPU.  If teardown observes next_set as false while the
> callback is still running, kvm_riscv_vcpu_timer_cancel() skips
> hrtimer_cancel() and kvm_destroy_vcpus() can free the vCPU before the
> callback enters kvm_riscv_vcpu_set_interrupt().
>
> A guest can arm the timer with SBI TIME and request shutdown with SBI
> legacy shutdown or SRST.  A VMM that honors KVM_EXIT_SYSTEM_EVENT and
> destroys the VM supplies the teardown side of the race; no post-launch
> host ioctl is needed to arm or request teardown.
>
> On upstream master 62cc90241548, generic KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in do_raw_spin_lock
>   Write of size 4 at addr ff60000005e58898
>
>   kvm_riscv_vcpu_set_interrupt
>   kvm_riscv_vcpu_hrtimer_expired
>   __hrtimer_run_queues
>   hrtimer_interrupt
>
> The object was allocated by KVM_CREATE_VCPU and freed concurrently by:
>
>   kvm_destroy_vcpus
>   kvm_arch_destroy_vm
>   kvm_destroy_vm
>   __fput
>
> For deterministic validation, I added mdelay(1000) immediately after
> the existing next_set =3D false assignment.  This only widens the
> existing post-clear callback window.  A no-delay trace build naturally
> reached the callback-after-teardown-start/before-deinit ordering in 12
> of 200 runs, but 1,500 stock-kernel stress iterations did not produce a
> KASAN report, so natural reproduction is timing-sensitive.
>
> Always invoke hrtimer_cancel() for an initialized timer.  Preserve the
> existing -EINVAL result when the timer is no longer set, but only after
> synchronizing with a running callback.
>
> With this patch, hrtimer_cancel() blocked for the full widened callback
> window before vCPU destruction.  KASAN reported no error in 100
> fixed-and-widened runs or 200 fix-only timing-sweep runs.
>
> Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.6
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup

> ---
> Changes in v2:
> - Add the required Assisted-by trailer.
> - Drop security@kernel.org from the recipients.
>
>  arch/riscv/kvm/vcpu_timer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> AI disclosure: I used AI assistance during the audit and am treating the
> issue as public as required by Documentation/process/security-bugs.rst.
> The reproducer and full KASAN trace have not been posted publicly and
> are available on request.
>
> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index ae53133c7ab0..a2cd277a4059 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -61,10 +61,13 @@ kvm_riscv_vcpu_hrtimer_expired(struct hrtimer *h)
>
>  static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
>  {
> -       if (!t->init_done || !t->next_set)
> +       if (!t->init_done)
>                 return -EINVAL;
>
>         hrtimer_cancel(&t->hrt);
> +
> +       if (!t->next_set)
> +               return -EINVAL;
>         t->next_set =3D false;
>
>         return 0;
> --
> 2.47.2
