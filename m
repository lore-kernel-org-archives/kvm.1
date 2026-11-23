Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460157;
	b=gMsnB54DuSm9R2nWqM7FOAeLXRwkLLR5T0GYU+xdcjh76/VcZd/MaN+w1EHZ0FBf3wOR
	 TJZzIHMsoqQ4SzplWeinaMoJcFYmTlAsR4HqeFYM/drwrYhS3z8hranYyBqwWmw35A1Mq
	 ilwKjhKlQJvQCuLewl7giVU2sfU7JmUICeNkC/82t2qjPlm0cAimIaWwrYug8zHC0efCo
	 +j3Iq/nBvlYjvuHDyENkR6Wdf3Qywa9DeCX9A8X3V56HaS9lV8LbQJHLqN6Z5AWDtDog8
	 gFPhr8Ey0cmx54YPEHwVkcfFsIjQ1zl+aZV1huLGHjj7GZQGE9oVnan3p2f3tjf6LaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
	b=1/dTcgsnv8GM6Hy2upbDqt0SZBSnnqmIRHP3y6nYK5ZpJPhfCQfRtJkAK5B2wbS6jwtC
	 2+HlS0CuEd2mnVfrD+agWjehL85aZ5eazxfcDReiKPF9GXJhGluMS7LJCzS3R8ejK43I9
	 xG9CfPraO+6wymFPllRwhVr/sI3Sz57X0zSYKeRUnsKRqWVAX0RFmdHZCVmRkybJLVIej
	 u+cay76zVvowg+0nExLhddVbXCag3V+gPzHc0Em0EBgBDhbOY38EkyDMLTbsjrQp9tKf6
	 dJXgSbyVe3FpWBAKX8bU8CQuKCk/H4ivbTkCH7Tu2BXuaOY4br8N8k3qPNZ2g2DTzdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SWjJFVer;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136F606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9136F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SWjJFVer
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so598594266b.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 10:55:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795460155; cv=none;
        d=google.com; s=arc-20260327;
        b=oM+q1JZBbkKx7d+UbOb+o8M/xvAvSoAlrx2uUMnJ77AWgYgdvJQ47A8HFMKLW8RQD3
         QrPtX40YOZ4utNvSyn7rqsWU6S+viDqAtkDQiwpCfAdWALVP8A1q9b4b0lGDDWts2o+6
         64coHwGPjTM8B3u7EvStdWu8XR8CJIcPw3KLQ+a4A+Vccd2nwWWGG3RJRVW+BHV5w58P
         zB4OPxYHtvTufoHzngE1cM2h1kAQVuvE7p5G75HfMjCicjLPReP9SXnQSVpfht7AF1Wh
         a4UE+IH2WlE3vqSrjoQZYRPQEUMn66CO15zA4MlCdH4QSle0gK53U7Dt6+yeu5Ts2n4o
         9dlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
        fh=aOL/6EqVu7QiTQsbrhdp36wrKqWV6zlWH7UQ5SYW+yI=;
        b=O1LpvplS8Yvkm6hVGx6rxw6N6tuzizjmXMGFob3xAAKzK9gRue7ROchX7WCzM3nklF
         F1ha6IDPmtHaka/IDV6uDo11sGSxhXfSI2BNEVTzq9UX2YWEYFbtpOJj+pbTeqVz6laO
         b06o6XIxN7O/MHwjYv1fR+6qO2AbxvrGn1XtwLHiuyeR7PAgd42etPKxq9a2fvQ4U2vN
         6CUOOokRFhvhysop5WUlyatXFzUP085m4hoh1xh3VCjpZ+bWCcOoph40OYhYNmWPrvan
         P4VX6/KJg3Dy72lGNeLTyWkYUvBGhSJgpJOCI+jzRI8T2Sv7BOXSCxtEuTPqD1gTnn0I
         vCZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460155; x=1796064955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
        b=SWjJFVerFZwp5gdpwgSwsHCvH/MuBZwcTTCLGvQ2+MQp4fpwRO1TEnK3PIl5WkZa/U
         4PYBssodVjWkRVnC2iPkYD4laPHHByLLCScMdEpXN4Fcji3zhcktPBk3hTnNfJvWWx6i
         +xT/2XPzIryntCkoeUD40+jQ9uoeFBS1E4DsHtsDFb5r+ZMBj4ulQvwbkFCvxi/wsmef
         tYLPWBzGqaQWWib7PVsEorJgj25Ih2Bn+igCF6imMbkjrGjtnADAPJuPHJvIXnQXn8Et
         jP0ZfP/o/b9OqmZGm5854VD3POC/VDiGbANhdFn7ir5sxDaBdPzx2VSmKpsAU4dHgfOj
         h97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460155; x=1796064955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
        b=Lth5qi+gAAbG7sjJ92HuiwAcGmpPqbVnV8dhyDootKOd4B+bSVawnKKXdqh0+OSNQG
         6GemYqQ48sS3xAAQOxOsWGf5nobqPbaYr+pMsI0/D0b/ZvDEho0zrCAs1eeS/sHhAEY0
         k00d88vHcXYksSyZfhmUgcQpBUnEkZKQZ2t4Pb7T5yfCxnbjsxs8l5HRNok99apJQjzi
         ijcSf5OVvjqQKOEu/+x7dVtizcjiWA9dX43rIBH8SUtBG1V05OhysSf0U61laIdIftrb
         EYpCNqRAGRnD+ICHZ3y9CH+0Ng0VhH8QY8fgn5nf1Ui+tj+h5v6NlraDxMPfserFoc/Y
         CkzQ==
X-Forwarded-Encrypted: i=1; AL+hErH77TN/nba/lcwiWqpMf8Po1GkHzOIxb+NCCmBENkHpbL6BVgONYYVMlHNvLw7R28+Ng+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UDuJO4pOG5Tl2IaeQAq29c5nEfnGmCsSqiH6BTQrpI0Xfge51
	pPATm2WjiuNYoyFg+Tu5oL8sOAJN5IrAD94teJ6Mey0kPgqUDlepEJhQCINyzWfQxNjgVkBiO2B
	QTrmeapFd8oN9TPkzt81M97HVdvkgfVyA/6aJXWnk
X-Gm-Gg: AZFdTZdWUW6KetjnNzDkiP/jCQFiQ/8+hA5TLWmal207uc8O1pmpY1Ig/zUVrGsISxU
	YTHDlycpPMl67vsjBNibzG0yP5pOC9Xg3UD2fzzEkCE2GVU7rDFMqxPL/bkTdoapEjSxx5/SIB9
	xQHT86VDnDmpvyjWnBUsUQkK/j61GreHyc71FUEyhVKhSG6pxpIqaj88rV3q7CQdRNQ86HgtwK7
	mgaAdUI7RV192R4QhQ33y1JiSDwoW/prWzZu1hJ72F4OkkIfVlvtFKBarsd6e30eJB7u1Nrbi8E
	lVvSVikOlijCDoGkFfmDbBwPyKZdQtTdSpmSVrWklYFGL1X7k0Ov4Bjfx5qgIWGDPe/Ok7roWuS
	0UIT2qyrWJp1Qa0a2Ku+3pFJsY8jNej5irsh4uUVabnL5k6XQXaYfO+/cKlG+8t2Vv4dvNxKUXE
	InCHH9zoSO0A4ylp6D6CilP8QKIt4pUYtXe6q160f/ul58llc+Pgc6zX9aTfwtXsuXe+wJn9A2
X-Received: by 2002:a17:907:a890:b0:c50:9432:b7e3 with SMTP id
 a640c23a62f3a-c513aace654mr1151233566b.42.1795460154527; Mon, 23 Nov 2026
 10:55:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123153238.1036972-1-smish149@asu.edu> <20261123153238.1036972-2-smish149@asu.edu>
In-Reply-To: <20261123153238.1036972-2-smish149@asu.edu>
From: James Houghton <jthoughton@google.com>
Date: Mon, 23 Nov 2026 13:55:17 -0500
X-Gm-Features: Aa3M54o3BkLplxoImmTCvpPC5WgG3n0ZneGbPk_xxpY2ZYPc3HauVZVJB5o2TiI
Message-ID: <CADrL8HWj6qLSB4h_JC7qSr6+t6Z6p7zzL7fgVne-m8_cfrHwOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Disable preemption while pushing to the dirty ring
To: Siddharth Mishra <smish149@asu.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:33=E2=80=AFAM Siddharth Mishra <smish149@asu.edu=
> wrote:
>
> Disable preemption in kvm_dirty_ring_push() so that another push to the
> same dirty ring cannot run in the middle of it.
>
> kvm_dirty_ring_push() selects an entry with dirty_index, fills the entry,
> and only then increments dirty_index, all with preemption enabled, e.g.
> when vmx_flush_pml_buffer() pushes the logged GPAs on VM-Exit.  If the
> vCPU task is preempted in that window, kvm_sched_out() calls
> kvm_arch_vcpu_put() while kvm_running_vcpu still points at the vCPU, and
> kvm_steal_time_set_preempted() or kvm_xen_runstate_set_preempted() marks
> a page dirty, which pushes to the same ring.  That push fills the
> selected entry and increments dirty_index, then the interrupted push
> overwrites the entry and increments dirty_index again.  The entry after
> it is never written, its flags stay zero, and the entries after that one
> are dirty.
>
> Userspace harvests the ring in order and stops at the first entry that
> is not dirty, so it never harvests any later entry, and the GFN of the
> overwritten push is lost.  A VMM that tracks dirty memory with the dirty
> ring, e.g. for live migration or to restore a snapshot, then misses every
> page that the vCPU dirties afterwards.
>
> Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory trackin=
g")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Mishra <smish149@asu.edu>

Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  virt/kvm/dirty_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 572b854edf74..1ed8b8771c3e 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -221,6 +221,8 @@ void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 s=
lot, u64 offset)
>         struct kvm_dirty_ring *ring =3D &vcpu->dirty_ring;
>         struct kvm_dirty_gfn *entry;
>
> +       guard(preempt)();
> +
>         /* It should never get full */
>         WARN_ON_ONCE(kvm_dirty_ring_full(ring));
>
> --
> 2.54.0
>
