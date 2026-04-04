Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741EA1E9919
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775300566; cv=pass; b=np6CC68nQLYsyle/3COSqW2ENsXBp6XmQ0THIwvVTIj/K3pV9mgoJATR3j1Kx8YhcPMMKaTNWcgyyRl1dXv/qU8PwCDAy3cV8IdK2jC1nJc7LhtikBR35kpgOnZMfUfL4pQyXrhMvOKKu/DB+tr0mNPtnKbwzi8Pzbvrry3xkdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775300566; c=relaxed/simple;
	bh=qQm9tBltYls3k/v6mMzJ47hisi6iCeBEZTaaYj42jB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL+kOn+c5YQHDWMdNnPYst5hkj9DyQavZYp3gQ6D2PHzhHiTDC0uVZpT8x2fs6d8Czq7NDzBuvKvhIasIk6zvjhfsgTnybpTW/pQbxXTr8oKN/DuinEDS9zPNUc8CoMYXVZjshtqnUr+h0iPPwH7IW5QtimLhLfPJ2JMAnI/n0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=NtTzD4UP; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="NtTzD4UP"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbba5076c8so636557a34.0
        for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 04:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775300564; cv=none;
        d=google.com; s=arc-20240605;
        b=IlEOAaZwck/rhUDp0e0FBdvNyaUV6EPRPmfqpiF8p+k9T1v/z2yyr3gWYsJUiVg3nf
         XVVV1P04ILNmnnAZjddjY0rpshYCJc5/wBf0H1EhfaBKtfbO9RNb6sSEKIvvSv4zj9lE
         uWRTwtJaOhnrZqU/8bH+Ylln2KMDdy5eDWwxF+uzILba+TEEEKXF/26adZABSgxn0agu
         kTc+YLggwHK9Acd9idgTtFN6RmevrVXv8NAaMm1FkEp6nlcvSVFyOQZSrAs2BtbDwFfT
         m4GiMXh/st18elM/PPuMmlwCCoDDV5JGOhbxGNvQ4Vnn0CkNL7tUtE6Loh47Y2j+q5sr
         kmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zfu5+ZoRr42kiqQcxjxD/Vr+HX1maiYTYcsoR4uKhiw=;
        fh=IM2fHqQ9OnJxddxkK6KdlnmMrGBDbeyKeD+8XfePOdo=;
        b=YiNYrYgm/jM8N0jGF8vKPUiPlBeDaNwapTirHBv1dgPa4SgTW93N5PQXaTeK87u+YG
         w74oCt1Ob52rgA/JB8q2gGouKi/iTPB8zJbwMlSKJoNs2rHS1nfN65WYced0AguZ6dRP
         Q2GReQ2THQHPsa2KegywjZKsAA4fq858iRkOwAuSuKKxOGm08ZyECZAihzwLromubheN
         754SL7kCqiZ2aJNRumhJyCMaJxZ+lcWr0TQgiUTcuL07B2hEhhgY+rwNDnUkvFMfqqQZ
         CwlalEOZJxy6ZBEfW/hm9mVA1Z2+Ld2dKIj8O9r+GpeJByT/Z21oQjQdKCyHZ16Sj09C
         644g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775300564; x=1775905364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfu5+ZoRr42kiqQcxjxD/Vr+HX1maiYTYcsoR4uKhiw=;
        b=NtTzD4UP7F1K6s7YplG4hFImUSTvGMubxPMlOYMTwuEY9J204KPVwFfo+kvim9MV+j
         5OUBAQPJe09/0XgQt33AeoU0G1g4HyooN9j5aJgpDBZRNp32ctCVqFopp9Kz986l9acF
         PkBxuDCcVtv1E4cnvxssGYOmZeDahzMsz3RY5+zSMa9P4wNGawPOqj3NwEIrw7GMdDIk
         zvTNtq6YDE2iB3n5O0h9D+D2YvxDHtZfqCI/eLQBBHZSMwuH3BCDLxnTb1JMW7osWZlu
         /23Pu8CXa9/ZAVlglC3DIEuClTdvtBErJdVq2udloSgBq6hZU11nnerCapEPuFqssMbF
         mWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775300564; x=1775905364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zfu5+ZoRr42kiqQcxjxD/Vr+HX1maiYTYcsoR4uKhiw=;
        b=Mh/olSYDnaQFfDcMJnDTncHg3eSEKIi4KEJtC5t4z3FMonHHjd/7CDfFaMRfvN2TBi
         Kc7WTqSKkFK7ve2F7aEVClzW80WIk67wk6mReFXJ+nlIPS2lK29fTuEr0lpu4RbQ/b/Q
         D0Pe2JrkdiFOajwyv6tUN1SN5FWFir4AhmYAMxQNbEOmjDvssPWqmPo6MPcQ3LA/Wmaq
         KHBs2VLwmm6Sbhjq1/EoSvQlm+vOSgFBCPP1alMHtihLkhB35Rh7Yu59y84w2+ZD6DEy
         mGcDYGjOLyU/lP11Wr9TiHqcnfTq5GqKSmhUnFyXesqFzY2gHCfTm9dCVjxseAUe67Hs
         x40w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5dvLWYsRrAm+qml65N2oRV1FAKsIM6aQCzH3vZhEyZHwVdAC8+tBOCHBNzUyTUXOyn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrX4RvwDoJvi43XKjJ0nCUG+SAehpw2ZmcxEhDGwfNevuRmoAL
	85ubEzKoyqJSRPHPwyecqgbaHrXPTPatXEa1YH+PlqhTYyiRDE96X9sVaajleR7xZ4yNgl/lF0W
	1p0WsLpYiCMstTOAl/94ukG9wuPvNqoWoEXC3OJv/FA==
X-Gm-Gg: AeBDieu4+ZwoFW7qgPTm2HWqNMb3nzP7GYzdvcBp7HW85CEXTNB2cntBK7YkruVGT+Z
	dQdkNKCAusnXgj/mW7i2k729msZ46P/OuNL6y4bDHEX3WpB08R2IRWTFlSNeSpa3nMht8VNappf
	eF4fiS+C7f8/ynoIz4N8qsmPagZP2Tm2KxiUujV8TU5EhzxLDy+UZNRCB6O8OuA7os1MbOJ/Vh+
	lBA6euJh0z6CNEeZLNrDD0xdRJj4e+cyjEz/CdK+Qkgx+BSV/dhDqQKfQWKnyXFDs6OLX6ujbiz
	w3XdYJXO9dbWTG1ZCFyhRKyGmyog7egkW8aPTj3yhtT97OsW16wsYR7uI5m2rXEi6/Y3hyA5sYR
	hzHcGWXr6YyiK6tzQIxtAo7VNrQ==
X-Received: by 2002:a05:6820:1ca8:b0:67e:3b11:89ed with SMTP id
 006d021491bc7-6821e66a08bmr3527858eaf.10.1775300564107; Sat, 04 Apr 2026
 04:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 4 Apr 2026 16:32:32 +0530
X-Gm-Features: AQROBzDcUt7d2zmN-LgKMz3EEMCzhGSvhLBkGZy88YajEYGJjZyDS4lDfZXa79I
Message-ID: <CAAhSdy2t2WukRG7mHckY5=+J4+vPU1jvkrG9vqXoDxcMPbiEJg@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Support runtime configuration for per-VM's HGATP mode
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	skhan@linuxfoundation.org, guoren@kernel.org, radim.krcmar@oss.qualcomm.com, 
	andrew.jones@oss.qualcomm.com, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:00=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Currently, RISC-V KVM hardcodes the G-stage page table format (HGATP mode=
)
> to the maximum mode detected at boot time (e.g., SV57x4 if supported). bu=
t
> often such a wide GPA is unnecessary, just as a host sometimes doesn't ne=
ed
> sv57.
>
> This patch reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE. User-space can
> now explicitly request a specific HGATP mode (SV39x4, SV48x4, SV57x4 or
> SV32x4) during VM creation.
>
> ---
> Changes in v8:
>     - Reuse KVM_CAP_VM_GPA_BITS to advertise and select the effective GPA=
 width
>       for a VM (Anup's suggestion).
>     - Handle the kvm =3D=3D NULL case and task kvm->lock and kvm->slots_l=
ock to serialize
>       against concurrent vCPU creation and memslot updates (Radim's sugge=
stion).
>     - Link to v7:
>       https://lore.kernel.org/linux-riscv/20260402132303.6252-1-fangyu.yu=
@linux.alibaba.com/
> ---
> Changes in v7 (Anup's suggestions):
>     - Keep the original HGATP mode probing logic.
>     - Link to v6:
>       https://lore.kernel.org/linux-riscv/20260330122601.22140-1-fangyu.y=
u@linux.alibaba.com/
> ---
> Changes in v6 (Anup's suggestions):
>     - Reworked kvm_riscv_gstage_gpa_bits() and kvm_riscv_gstage_gpa_size(=
) to
>       take "unsigned long pgd_levels" instead of "struct kvm_arch *".
>     - Moved kvm_riscv_gstage_mode() helper from kvm_host.h to kvm_gstage.=
h.
>     - Renamed kvm->arch.kvm_riscv_gstage_pgd_levels to kvm->arch.pgd_leve=
ls.
>     - Added pgd_levels to struct kvm_gstage to avoid repeated
>       gstage->kvm->arch pointer chasing.
>     - Link to v5:
>       https://lore.kernel.org/linux-riscv/20260204134507.33912-1-fangyu.y=
u@linux.alibaba.com/
> ---
> Changes in v5:
>     - Use architectural HGATP.MODE encodings as the bit index for the sup=
ported-mode
>       bitmap and for the VM-mode selection UAPI; no new UAPI mode/bit def=
ines are
>       introduced(per Radim).
>     - Allow KVM_CAP_RISCV_SET_HGATP_MODE on RV32 as well(per Drew).
>     - Link to v4:
>       https://lore.kernel.org/linux-riscv/20260202140716.34323-1-fangyu.y=
u@linux.alibaba.com/
> ---
> Changes in v4:
>     - Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE value=
s
>       supported by the host and record them in a bitmask.
>     - Treat unexpected pgd_levels in kvm_riscv_gstage_mode() as an intern=
al error
>       (e.g. WARN_ON_ONCE())(per Radim).
>     - Move kvm_riscv_gstage_gpa_bits() and kvm_riscv_gstage_gpa_size() to=
 header
>       as static inline helpers(per Radim).
>     - Drop gstage_mode_user_initialized and Remove the kvm_debug() messag=
e from
>       KVM_CAP_RISCV_SET_HGATP_MODE(per Radim).
>     - Link to v3:
>       https://lore.kernel.org/linux-riscv/20260125150450.27068-1-fangyu.y=
u@linux.alibaba.com/
> ---
> Changes in v3:
>     - Reworked the patch formatting (per Drew).
>     - Dropped kvm->arch.kvm_riscv_gstage_mode and derive HGATP.MODE from
>       kvm_riscv_gstage_pgd_levels via a helper, avoiding redundant per-VM=
 state(per Drew).
>     - Removed kvm_riscv_gstage_max_mode and keep only kvm_riscv_gstage_ma=
x_pgd_levels
>       for host capability detection(per Drew).
>     - Other initialization and return value issues(per Drew).
>     - Enforce that KVM_CAP_RISCV_SET_HGATP_MODE can only be enabled befor=
e any vCPUs
>       are created by rejecting the ioctl once kvm->created_vcpus is non-z=
ero(per Radim).
>     - Add a memslot safety check and reject the capability unless
>       kvm_are_all_memslots_empty(kvm) is true, ensuring the G-stage forma=
t is not
>       changed after any memslots have been installed(per Radim).
>     - Link to v2:
>       https://lore.kernel.org/linux-riscv/20260105143232.76715-1-fangyu.y=
u@linux.alibaba.com/
>
> Fangyu Yu (3):
>   RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
>   RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
>   RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE
>
>  arch/riscv/include/asm/kvm_gstage.h | 47 ++++++++++++++++---
>  arch/riscv/include/asm/kvm_host.h   |  1 +
>  arch/riscv/kvm/gstage.c             | 65 +++++++++++++--------------
>  arch/riscv/kvm/main.c               | 12 ++---
>  arch/riscv/kvm/mmu.c                | 70 +++++++++--------------------
>  arch/riscv/kvm/vm.c                 | 49 ++++++++++++++++++--
>  arch/riscv/kvm/vmid.c               |  3 +-
>  7 files changed, 148 insertions(+), 99 deletions(-)
>
> --
> 2.50.1
>

Queued this series for Linux-7.1

Thanks,
Anup
