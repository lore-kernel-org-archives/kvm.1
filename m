Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C383264CB
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786791533; cv=pass; b=HfXUN3R/cCeRk8EHvc3d4mCsGvzH1lIoTiWlZoTKVaB6huYSVMbmdsfbKmYqORgpwtbIWkDNM9Zjm0ip/7RUehYXB13dHQQZNqtcIgLBzmuXuuZgPBccmS8vo5Ua6z1/7+HPzbXH6IP5C21kMOCVLuFoUMYLkde28RGCMOZPo6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786791533; c=relaxed/simple;
	bh=/TXxw2YcJSUXGfaH98X+AYuPTu8dhuUOdOppx46QCxY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NvvZHIlRcirmkxSIDah6bzQZyCbuB6kjjORqoPXaLGMjvZE3HrpuBJn7Dx+cVf9bJ5wUVoG/HzYWgRTAVtb+8UmFlD3eCEE+hk3ohTEn2KFJ2dZWQyZaQ+ksN7EyS2FKLM2KgYz6Ruw8SexiMh6ojkX6pwKyg+mbeAe+5mefg88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=KY2mGjij; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="KY2mGjij"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe89fb333so1075923f8f.3
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 03:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786791530; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwHtgyUXRhmuHm7fVGEiff/ko4DSTVQZyMbq9qH2IG5z0/i3rYh0u9V2jF4dX9rrQ8
         8JsVyUM2hJEQCG5mMKSGjV77WvVVgrx8RFA+aBIjlVxOuavgjfVn+TWmioM1lGBiCO/l
         dyGLkbRHShCYW6Utw/q0COrypeqcQY3otjpExj71bHWFZESToKVmIQY8H1JgjEy56dg6
         sCa98FL+ucSCmvcWUhR++WTxieXoDbEaoSlxHb+WETIHWs7a+Kct7VwyPwukb1dZJeL+
         Whur0/yoqlZKhDKiFgDuE8Ci/jtxF+MeFc2wupNG87pdOwDFfnBwCARE18mtRuomyhpy
         ebMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mJc/szzNzWXMtgLBzdckrrrIF9x+kqLUtWQrhBRAmT8=;
        fh=qy4JdraMdaC4lBRtYZiS7VoFcWW7ht9FD6WqIRg6Uds=;
        b=cBBeosbmN8FORI5otaA+YoKoVj1TM4/7xcSzvnqGXmt/az09+JvHY1q7t5PYGO3Elk
         97BwUi62Xjdzz0Foj+4C1XHuBuomBUostyGMMeeWMlZNjJWQ1vkfmXtK/yMfmBnj+T60
         eEZml6bZvYcbj32q+wc1GHfzzvxwwkAzKX0YUHXlPTVh8RRPG1ogJ0bBGOLz7XkiRjyB
         7MmY7Oc1CCeCg98XBMSQRK0K/tI4aoDwuqUiX28ZsIm6s1knwaMefAwr0CXit0x5RPCW
         MgZ0FjjTAv+mv4t74k7PR6d/nXjH1V3ceMyeauksX8UL9IkivA0o6CIGBc5D6yMAJLUK
         xHWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786791530; x=1787396330; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJc/szzNzWXMtgLBzdckrrrIF9x+kqLUtWQrhBRAmT8=;
        b=KY2mGjijdsv6Mtj3+ij/Rt7CRSXlQAaH9S8zkB/d9zcBihmoKBXoTa+KNcoFeTy9an
         vv4jWURyihTxbiWBinzErHKql79fLfgtmC9Wspaw91Dfr78nFKI1vxtq3B1fpSDpck9u
         eZy2cc4XQpkZD8lCiO1W8mNP0Zrv84R6FldASVTZixNWBjKwdeBxADPBRT8LDJJN5xny
         FCqnc2vB9Kq97/e+2/+2hZVFIBAHaZklJN2Z1hOADbz1oIv2n+9lluoN2ChdYQgqvMio
         nmbu1aX6jtFPduyvg3+Igpii1tBrXoi5mk5gPgkg6qD1MGeeEYUsFB3rcERTrAuBAZ/t
         q+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786791530; x=1787396330;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mJc/szzNzWXMtgLBzdckrrrIF9x+kqLUtWQrhBRAmT8=;
        b=lIT2o3s9tMEEyiKxPhtxfW4ZePYDNjacu8n8GYh7mZfGecFPqyQsjzfOoK3G3Q4gDg
         RlhGR3UhyEL/8nZPmetc5EWC7pCmEhh3BrjJG8Wpi5DHz/+wRmq7a9eAKOOEyrpNFSCe
         HtiwVd7qCt5PfORae0TWM2+/v8KXi212ngqv9ct11o5AI6822x6pIQjrvigsEy/LDK+e
         o9RFy/KDUplTTlwT96mJQXhN+Yz/orpPGc9rSq7pruxckdak3Tl1w1E3qHAa2WI26MIS
         veqgfvacBEyNQ8vt/pgMlCwIhsK0oi6oke0O1olNdPJGWiYckLVFiJ+Q/0Dft4TAFT4B
         JzMA==
X-Forwarded-Encrypted: i=1; AHgh+RqnUqDd9lJkKQNESVAwDcwAlvr2cd17NrjrLrl76P3PAH6x8MXx6MjCnEuWf3FPayuaJxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFXmi0ToWEIyw6YJrIRVFly7A49aUkOd3ytML7SKa78I7JeJP
	eVRH1NWu5+5L1cvuy3JoqQnTr9cXABygmMK/RZcVZTkxzuoTIhrhq0treTHbmQN/D2cgHZ91w1Y
	8P0PUzY/NYgp0Doh6E0tbStxolFuQQe4uz76tTLRIng==
X-Gm-Gg: AR+sD12yPxUCG621Fz/KwcaF1x0Qw8atjVJzBtqT+Ku5qy9P8+RJsebUKRY9VENTNsu
	5YPaSXdHWvQKK2a3pnFVHchZv/7emnKqem8rsCr3n2jbdgSCLIyI+PfGNU1YIx1nqLmEzHd3i16
	BJMDw1LMf/CHrGCZoIpDHLxVJi5MEKTt30DP3/J38D1jatqNVqehwvOSIATCaiyrquBnUAQ8ji+
	7rIBdKLPQ7nP5HK3IZdIVjsLDsr2cAufmlSGnEtV8+h8snXjHswCzqUyx7CMEXjWx6frTnYSUwd
	sRPFbHwA5Su+nhC8zhobtY/xD5+aiGT0d5sJGKbjRUr0GRg8XD/jahmXa2cdwvn1TbCRZYxr03M
	T6ImyRiP5P0V20aVbLKSwdcQqf0XbVMeUgMZMcjEOmA3Cen/YSw7t69NlTWTktBU=
X-Received: by 2002:a5d:5f95:0:b0:481:568d:7759 with SMTP id
 ffacd0b85a97d-481607a8cb8mr18006131f8f.24.1786791529832; Sat, 15 Aug 2026
 03:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Sat, 15 Aug 2026 16:28:37 +0530
X-Gm-Features: AcwNN1XpJvJiEIJbZgwLDNwXgQA4L3oZs626j0Q3Fhh-BkbsS9CxXWYf4rtYk8c
Message-ID: <CAAhSdy2AOkykd1JyrF6kJNsZv9M8rYJqVX1TUZNe3RDehZMxHQ@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv changes for 7.3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following KVM RISC-V changes for 7.3:
1) Svadu/Zicfiss/Zicfilp FWFT support for Guest
2) Use try_cmpxchg for IMSIC MRIF RMW
3) More arch-specific tracepoints in KVM RISC-V
4) Eager Page Splitting for KVM RISC-V
5) Optimize hfence request handling for SMP Guests
6) Improve dirty log clearing by skipping zero bits in mask
7) Guard HFENCE range loops against overflow
8) CPU PM notifiers in KVM RISC-V for non-retentive idle states
9) Fix kernel-mode vector context save/restore for Guest

In addition to the above, we also have a few small fixes such as
limit checks, array overflow checks, data type changes, etc.

Please pull.

Regards,
Anup

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.3-1

for you to fetch changes up to b5060a4aa33d7d78a8c1837ab08ef0c81ea96650:

  RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector
(2026-08-13 13:20:02 +0530)

----------------------------------------------------------------
KVM/riscv changes for 7.3

- Svadu/Zicfiss/Zicfilp FWFT support for Guest
- Use try_cmpxchg for IMSIC MRIF RMW
- More arch-specific tracepoints in KVM RISC-V
- Eager Page Splitting for KVM RISC-V
- Optimize hfence request handling for SMP Guests
- Improve dirty log clearing by skipping zero bits in mask
- Guard HFENCE range loops against overflow
- CPU PM notifiers in KVM RISC-V for non-retentive idle states
- Fix kernel-mode vector context save/restore for Guest

----------------------------------------------------------------
Andy Chiu (3):
      riscv: vector: refactor riscv_v_start_kernel_context
      riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
      RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector

Bingyu.Xian (2):
      RISC-V: KVM: Use unsigned int for vma_pageshift
      RISC-V: KVM: Widen G-stage fault address to gpa_t

Guidong Han (1):
      RISC-V: KVM: Fix PMU event info array size overflow

Inochi Amaoto (11):
      RISC-V: KVM: Add support for Svadu FWFT features
      KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
      RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
      RISC-V: KVM: Add ssp context save/restore
      RISC-V: KVM: Handle software-check exits for VCPU
      RISC-V: KVM: Add support for control-flow integrity FWFT features
      KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test
      RISC-V: KVM: Add SBI extension validate callback
      RISC-V: KVM: Add SBI FWFT validation support
      RISC-V: KVM: Reset the SBI extension when disable it
      RISC-V: KVM: Mark the reset callback of FWFT extension always dirties CSR

Pengpeng Hou (4):
      RISC-V: KVM: Allow memslots ending at the GPA limit
      RISC-V: KVM: Reject overlapping AIA IMSIC address fields
      RISC-V: KVM: Guard HFENCE range loops against overflow
      RISC-V: KVM: Avoid one-word masks for SBI v0.1 all-harts

Wang Yechao (8):
      RISC-V: KVM: Add the split page cache for ioctl context
      RISC-V: KVM: Split huge pages when dirty logging is enabled
      RISC-V: KVM: Remove redundant TLB flush operations
      RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
      RISC-V: KVM: Add the eager_page_split module parameter
      RISC-V: KVM: Separate req and fallback_req masks in make_xfence_request
      RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
      RISC-V: KVM: Improve dirty log clearing by skipping zero bits in mask

Yicong Yang (1):
      RISC-V: KVM: Use try_cmpxchg for IMSIC MRIF RMW

Yong-Xuan Wang (2):
      KVM: RISC-V: Clear former VCPU cache on virtualization disable
      KVM: RISC-V: Add CPU PM notifier for non-retention idle states

Yuhang.Chen (1):
      RISC-V: KVM: Add more arch-specific tracepoints

Yuhang.chen (1):
      RISC-V: KVM: Account VM-scoped allocations to the VM cgroup

Zongmin Zhou (1):
      KVM: riscv: Fix infinite loop in NACL hfence entry allocation

 Documentation/admin-guide/kernel-parameters.txt  |   7 +-
 arch/riscv/include/asm/csr.h                     |   1 +
 arch/riscv/include/asm/kvm_aia.h                 |   3 +
 arch/riscv/include/asm/kvm_gstage.h              |   9 +-
 arch/riscv/include/asm/kvm_host.h                |  10 ++
 arch/riscv/include/asm/kvm_vcpu_insn.h           |   4 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h            |   4 +
 arch/riscv/include/asm/kvm_vcpu_vector.h         |  24 +++
 arch/riscv/include/asm/processor.h               |   8 +
 arch/riscv/include/asm/simd.h                    |  16 +-
 arch/riscv/include/asm/vector.h                  |   5 +
 arch/riscv/include/uapi/asm/kvm.h                |  13 ++
 arch/riscv/kernel/kernel_mode_vector.c           |  88 +++++++---
 arch/riscv/kvm/aia.c                             |  42 +++++
 arch/riscv/kvm/aia_aplic.c                       |   3 +-
 arch/riscv/kvm/aia_device.c                      |   6 +
 arch/riscv/kvm/aia_imsic.c                       |  18 +-
 arch/riscv/kvm/gstage.c                          |  82 ++++++++-
 arch/riscv/kvm/isa.c                             |   2 +
 arch/riscv/kvm/main.c                            | 112 ++++++++++--
 arch/riscv/kvm/mmu.c                             | 108 +++++++++++-
 arch/riscv/kvm/nacl.c                            |   2 +-
 arch/riscv/kvm/tlb.c                             | 117 ++++++++++---
 arch/riscv/kvm/trace.h                           |  81 ++++++++-
 arch/riscv/kvm/vcpu.c                            |  34 ++++
 arch/riscv/kvm/vcpu_config.c                     |   2 +
 arch/riscv/kvm/vcpu_exit.c                       |  20 ++-
 arch/riscv/kvm/vcpu_insn.c                       |  17 +-
 arch/riscv/kvm/vcpu_onereg.c                     |  68 +++++++-
 arch/riscv/kvm/vcpu_pmu.c                        |  16 +-
 arch/riscv/kvm/vcpu_sbi.c                        |  30 ++++
 arch/riscv/kvm/vcpu_sbi_fwft.c                   | 207 ++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_v01.c                    |  52 +++---
 arch/riscv/kvm/vcpu_vector.c                     |  26 ++-
 tools/testing/selftests/kvm/riscv/get-reg-list.c |  90 ++++++++++
 35 files changed, 1169 insertions(+), 158 deletions(-)
