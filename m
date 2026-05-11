Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1030BF5C
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512837; cv=pass; b=q3iIwVMvIFMDXeVz+dgb9Cu2EIatHZZZlhgkd9sVbfb4vEtHHM+SPQijvk1aJ/sxFmyyZx+w0hRq4yEqkqgfcp9yXY5H8Gh8Ql68tIx4UUkxzHZ1nfT7NYV4hKedoiA2icrjiBqR+jrNEbK//jYG93OnDf4Mg4ZycO+NVUcp504=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512837; c=relaxed/simple;
	bh=Xz4fYGbS7i/Q6Qi38Fw9U1gRgtcym24JZtgZTH7Ivpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InaJKWyBOENAz3iDzObWz1HKAuckCq+RKs8yd8wXSLUn4hkYiTCL043yS04PLUa5+XelyaLj2l56QS9bn5ZwCvGdxIW6m6RdxMfohkrtbL1BMXYXUZKIcl2c/2H6Y5KcwOa+9ChqG+4RP7RwAIL1xWLCSOjKWe7/2il6T6z6gzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+UFw38a; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+UFw38a"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d6b393d60so1821cf.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778512835; cv=none;
        d=google.com; s=arc-20240605;
        b=Ujz0QN0aIZULfj3J1LSS9FGOl9mrM/hM2HWQZo482rQ9fs+M2vlvMvpLcB+Mnmce8U
         dGyVT7eXY4kvHk3KhhIvgtKcSxSkAoBd8nGV/q3D+qcht186MCawmoXyQFQrYznjJ2kr
         kKrPDtI4ocKHdzjEQou6RqD3mY9GuUqH21qFW0IuJ7U352At4Sv3XUqusPjZKoZM81I2
         5FZgwE+VoKMzr02Bp2YYw8APZWYqbPa2+VYgo2l4R/DgP0pw40cO8QtDPOChnHSKveAP
         H0riSb6dW6VDn6xNshZ0JPH2DZbc6EgbQyN45vgIY/9ZWXaq+SP66eV+zrVr2CLQtHlN
         Qd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y5WEI3bc+jKa5pFUDTyUeMXlg9f3nphKAR2eDCdRxOs=;
        fh=AuX9D+vIMigEmENoBw0idI3fF18RIbLp8Y8u8jYV7Bg=;
        b=g5W/BERf7luCoJ5tj3Eh3oT4NEg2TVOHd3Og7VFciev4drtAgRbg/BwX583hX7Cn0T
         BKT3DlBImOMycVjKbkdtPwY0wjc5roZDoxgPO6ceNwLR5I8QZOn+X3xPvzeGxACzP4JA
         pBDrHnunrh2hlR8KG+EnIDuSjubPmaF9qyA3JjvKiq4Cf8mLNP54jmz8nJ0rAYKuAF5d
         oxPb6qrZ4c2GL9+Rhy2CuVs62l5wCOeIYNGdC0389r9FS5BsCl/JRPJob2HSpHOrZVmE
         H8F9Ri54h1ai0+zxXrT0REA49+Ok2QTfbzkKEcu5MLK9ps3+Rh6hJUcc+wbDa/PtnhBm
         iBCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778512835; x=1779117635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5WEI3bc+jKa5pFUDTyUeMXlg9f3nphKAR2eDCdRxOs=;
        b=F+UFw38azYz5/t4UH1oB85x0EqUUKQ7HQrL/heb6CdlpS3T4JCuJdkz+xNeLBMeir5
         QmzCYgGsQGWVvrTbfqk6llbVau1YEKG4owOU6UFbTKHJeH25jRKXzJPOc6fjPBDgcZYH
         TOXukyXrsuYwFNA4dFVc130BZ2XGxTvADUyyjtkCvSyYoMepQskiXe7bda0hz2ZSPiSh
         2sUfLZUarzrQnDScPrVHG1H57vDVAD3BOb1MxwO905pMaU9tzC0yaTqN8F80OjKP39XB
         TtOq/dbI7RgQk9jAkhMJLQB5kIEyE526kDEL35BCk1zKgZEYoQ6+UR/NZbJj5VYTThEo
         FVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512835; x=1779117635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5WEI3bc+jKa5pFUDTyUeMXlg9f3nphKAR2eDCdRxOs=;
        b=EDrXJyR9UIyfj6ygebWURNyBc+ZwgBXqHKTXdKH/h8bQ6Z09B3lTMq0/X/4M63DXrS
         aJBtZ39fNq4llN16Y+0mWPl19y4Hrug/Y+CGp3Jwu/h2mIh9w9YAVAMsOSwiJvIQ9u4t
         BYTJwWLU3WjmgtCZglQ9eIYECQ1FnyqvwXvTQlcECRZdpO8WPFGcicsJZhvjirNfYiNy
         AFcGnKMUrGPP6iSx6gDetJWx2MdO3yzvq6F1yy5UbYJhCgTeTldUc7s+CNhuM21Y5+Yn
         cOWiVDKtvb2+Ikgv9rx6RnM47Y6nPvR8e2fnt9UFdpfj+b5LJSjdxtOGcl8roqK4t0KC
         /D1w==
X-Forwarded-Encrypted: i=1; AFNElJ/saWr1dramJIxG+sq+XiNEPsk3ghenJM6gGEwP08oLa/9I5SkIP/m8DD/YWxxie0o4u+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymo2SfMzOcxrFZxUG7JfQpfr/xH3AkrgD2YX8uewOecyFmKlTW
	i4TzIK7YF8cefPA9Cery4JQDehg44HTCTnr1Fqqk2K/AIVjaFErF7Naym/fDNYvNonGHfGkt3Ej
	4I8GqYZHUjGN1q/dCdvjMKa0uWjwVdbx8vQr+hPW4
X-Gm-Gg: Acq92OH2JG1CQg2rhRGSQGBqzKOblJqKUjam0JNEB/l/X7dO8ZhSA0UnKh+U/94MouK
	IMj3Jd8llaXhF/16qAcPeQcuVZuRI0+AHgoU1ujDLRMFOT9nEGADMST7uc2bqQ95+3jOe1OLX/Z
	PKjCNWpmYwEIPhWCbNJ9AJMi9JXvSoPQ2dehdc2cyKGE1//dX64SYvWCHDQ9mP8XbERv+nFq8uH
	dszXMAsge3L3ZEScpI/rtOZs9Rz4CoaZIlUWKzE17pTsU8D8xqGDdEgbUSJq9hbXF50XzIeUzVA
	4IDJCpbaG0uVUymbBiM=
X-Received: by 2002:a05:622a:152:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-514a04b4d5emr2366971cf.13.1778512832483; Mon, 11 May 2026
 08:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
 <agHugdIrptaXZW-2@google.com>
In-Reply-To: <agHugdIrptaXZW-2@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 11 May 2026 16:19:55 +0100
X-Gm-Features: AVHnY4K0xwc8Hb8-5C7f-YejfzbLAhjXF8he_JFEhS_49b6vZjQIeDztW1ArGj4
Message-ID: <CA+EHjTw1z7ROF7u0fKqxDGao7S1kELxNWtyWhLoPQx5uwVfuWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 15:58, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, May 11, 2026, Fuad Tabba wrote:
> > kvm_vm_release() closes vmp->fd and vmp->kvm_fd unconditionally, and
> > kvm_vm_free() calls kvm_vm_release() at teardown.  A test that calls
> > kvm_vm_release() and then kvm_vm_free() without a
> > vm_recreate_with_one_vcpu() in between double-closes both FDs.
>
> That's a test bug, no?

Fair point.  Let me describe the actual use case and then I'd like
your guidance on which way to fix it.

The pKVM selftests I'm preparing need to verify that protected guest
memory is zeroed when the VM is destroyed before the host regains
visibility of those pages.  The test pattern is:

  vm_userspace_mem_region_add(vm, ..., GPA_BASE, 1, GPA_PAGES, 0);
  /* run protected guest, which writes/shares/unshares its memory */
  ...
  TEST_ASSERT(get_proc_locked_vm_size() > GPA_SIZE);   /* still pinned */

  kvm_vm_release(vm);                                  /* trigger destroy */

  /* host_mem is still mmap'd in the test process; pKVM should have
   * zeroed it before unpinning */
  TEST_ASSERT(is_zero(region->host_mem, GPA_PAGES * PAGE_SIZE));

  kvm_vm_free(vm);                                     /* tidy up */
  TEST_ASSERT(get_proc_locked_vm_size() == 0);

I used kvm_vm_release() because it's the only public API that closes
vm->fd to trigger kernel-side destruction.  But the existing callers
follow it with vm_recreate_with_one_vcpu(), so the "release + later
kvm_vm_free()" path isn't exercised today.

I see three ways to make this clean:
  a) This patch: kvm_vm_release() becomes idempotent for its three
     FDs, matching the kvm_stats_release() idiom it already invokes.
  b) Leave kvm_vm_release() as-is and add a dedicated helper, e.g.
     kvm_vm_destroy_kernel(), that closes vm->fd to trigger kernel
     destruction while leaving the kvm_vm struct intact for
     post-destruction inspection.  kvm_vm_free() learns to handle the
     half-released state.
  c) Something else entirely, e.g., the test should manage vm->fd
     directly and not rely on library helpers for this pattern.

I lean (a). (b) doesn't really avoid the change, as kvm_vm_free()
still calls kvm_vm_release() internally, so either kvm_vm_release()
gains these guards, or kvm_vm_free() grows new "already half-released"
state, or kvm_vm_destroy_kernel() open-codes the same guarded closes
on every FD it touches.  (a) is the minimal form, and it lines up
vmp->fd / vmp->kvm_fd with vmp->stats.fd, which kvm_vm_release()
already handles this way via kvm_stats_release().  But happy to take
(b) or (c) if you'd rather not broaden kvm_vm_release()'s contract.

Cheers,
/fuad
