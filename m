Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794876536;
	b=Ddb5PEkNHwLhfFq6Al9EHLQZp3ak04xc7uhkpkaapGM64t7eT22gbQuBSsPonGF9/mBI
	 //ctkms2ctg6IEqmHjaH/bl9zttqWugB6cveKIggOb/6K6U4IA1ExOITpCDY1ThTiAANu
	 fnWCz8vVwlXhNON/0yEqXwvDCCHTJtAjy2uevbWxCN7Mlw+qxfLpBQPLJfexukJKzBE9h
	 kfXm2NZlIL7B+l+MOHJMQBuDHfLujdgv9lJbIU4sYjBoDEph3WG8NgWor4Vw2pY1FPFJG
	 KTXPCPAzWOW0EI8P6vmgZN9Kpoe6vB+VohNXajRoljQ+Cgec0Jbu+CPpQTLnnvHoUSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rzJlq1cSSvpPNomsaRs/y8mYSY2mPGAAaxTHlWFvxNs=;
	b=ATObTU/sxuBCcVd9C2oiGIdeul5Rr9r/X7bqSHDufRBll3uHsdFRQoy9MJ+sW2nUkRAh
	 4bbJYIXkSC9GCtH5uwyzTVa92We0mVUppLE2nWV6PEDZX15FQ4qMvPNaZ9dO/rQ8VUY7F
	 grUb/ZECIJP6VtA17EvGEiFXdaf549W+I26bCYiYkz6VQDfNR0Qj1Qw5hXshb0sR3xLmJ
	 EPLstM2Qu4G1aPn4SLNHnBMvA29XVNnb5XWRHIrYDywcpMU5403EfMDDBM/wzjznW7r8r
	 YHymbmrs24PurZdukvy8Btqzt/e2MmxJ8d4HPzfmQnEwlsqZWZSjMzzK/CXu0HrjClA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpQK+XTk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F01606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 00:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F01606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpQK+XTk
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso6587a12.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794876534; cv=none;
        d=google.com; s=arc-20260327;
        b=Yo8bRehe+dJL0KVIy/rjUsdvi1MEWSosi/SwyXBvWbfAmsthFq6J4hStX4qrOdUmet
         W5ilCPqSM9DL7WNV4dxYoL+L5b5RewoE7ZgSUS0ZvXPcg9r2NG8c98j5Bl3zx6Ja+Bpo
         07iusW/j9D9I32pq4n7UxYjqk+mCcMS/dGCMBF5iarmf+h8OPiZAmKrptlRQclnnVkTd
         vlKI9VgHssvB54WmRmDItVmBB5196MGQISgWNxoAdhEgS9WnMJ6a4jBm0KvWQlBWWGCx
         53vqEGgeqQO/stZhOezCQu9nQi99BFORyrSYEGrUUUX1PMnnnZqiKzotRj95JzW8V8OQ
         mBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rzJlq1cSSvpPNomsaRs/y8mYSY2mPGAAaxTHlWFvxNs=;
        fh=S2r+LnbwUVdkaiEkV1XdiA+JIvVyXQtW9bLCLrDV5UI=;
        b=qrE/ydUkuLqjpEU60XpQxRYrxX38aouSacMgOGZIOK0c7VfnyMV8ltFjOXtBYzV7a4
         2L/GnDzLy5ipiu0Bvvx81k/VbH5YDEn2cSx5xxeXOi3zE/V/1OQU6ik9cvXiKk8+bpRO
         NVHg6VDneEgTQbedTfCWXz44hAINXHla4bU7CE5Ti/Qrb84hequJLuiVPisPLCFvvwa8
         brSoNQognyuuDqyMA7B5aGaesVMEqYukzhx4GUOO39qnI2+E7gIwr8/Ca2btHzOyeceH
         PI8THdXs3FAX4dlKvz8zvAUiJqRhKShUPAApRqWP0whrju8mt1A5yW79J5ZSyIQUIYl1
         ilTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794876534; x=1795481334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rzJlq1cSSvpPNomsaRs/y8mYSY2mPGAAaxTHlWFvxNs=;
        b=LpQK+XTkznPKynwMpLTifIIBrRSA/MRdl9ZsjlqfqPI49rrh8KnsKwANgEipMPLUvr
         2LLOabuHTRTecPVfrV1mx2iFfT5BvJ0IuQqaYqNxXxusko+4H7shWfhAZcFlvyJXkeHs
         U28A1wz9FTmfvUX7iSdScs6Ce4N2fSs2wHumUSypOevxj/Sz45sPbGmbBJyX3gGYd2NR
         BQ4FDM7KuNZL3oo1NKspKKFSpRRRVAtp5YWaYlXeIRXZvZaQl0XVYfsIIXnfPrVXhMIh
         9o82A5pck6wwM7byI1EVevD+0o08G9HAncbAknCc7XootGlX/HguJ1/cLZWhXOOM1KLw
         qXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794876534; x=1795481334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzJlq1cSSvpPNomsaRs/y8mYSY2mPGAAaxTHlWFvxNs=;
        b=XALKFTya+0skiztoN4S10pqNqc/kYPL6tqX5W/P4Zp0CtzApCXx/kMqv2LKqLt+Yew
         GpZ+Y2058B9NM24CDHA315W3iY0PiVhblLITAo0TmMm6a1RepvA0RQV0hM0LusiJotMN
         Tdy8REcmVZKRzUTmoH8I8XBtpJkxUQT0Hp78FH7OD+rXkMTBNiRdpq9QPLBVG7cfaB/x
         UVdo1fpQX1W/ysN0GfSZ6zn/Yu8QRzEJ2uyVKC6PJF/TkC9KlXV6/k4e+Le8QhgnX5Rb
         tdknGUoxckyH4XChBu79+11c/t7Pkb5Okblcp/QFGGtjxwXnwGACjip9Br29U4/E4v2E
         2EVA==
X-Forwarded-Encrypted: i=1; AL+hErHJ0iktTUe+ArRKTMk4/T47v/1nIY5U5p4bGnVUmhuLyOqi5Lk8F5/bXO9cjYAvUh8wnCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+32dGahaCEniA9S6zLIdJT9j38OzvYQDqq+wlOk9+zgQqTTSbq
	FrOBqdb/AQYhtZCQxqIei0atae1QNtqPOxL9BsNWlAnQokRYYvluFyYJxkjsDFdm6m6A8lKc4aw
	f9PU4pApTbL1dbxZG9DOVMLoDNqi/PGRY8zscGY24
X-Gm-Gg: AYBFou3yv1aAUC5IDuQEBfRMKHdSPjBpyNLrRVKZzcxkSlwypIGiUzRX2xnZVm3/W6r
	JSXKWHsy1YZfHdS4Egmir7cLAHEGap6N0eP91Ix6OOPgZDMViE6yBvuX1fQ6CzUNc6TzGjYtWak
	IiP5yrxEUOzNKwHcNKxIdQD/W49VusAuvXbfajgG5UpemE2TjCVGMFw3eivTz+E+8fGm8tpeo16
	9W85t767ogU/DsRzX7ULlr8B0kUoXRHcpVT/x++6SKf7ckDX7Ru+wKtDyYa1E9WZArMu7XVCwNR
	guzRShyTyMsB33mC+mKeEoA5OKIItq1GBcFG4yRRAmrDRIeAHx4UKoi6yArYpfWki2Qer4Y6HpS
	UEiKvArVH0z6ZC0mFLbrCbPPn00HB7uaf/KfH30Z51oCZtdOxptVWzcf6DYWJgXJXy0aDeDO41N
	TokeFbbIbCgrINNJSHsw==
X-Received: by 2002:a05:6402:c51b:10b0:6b7:91a7:a637 with SMTP id
 4fb4d7f45d1cf-6b85b54dacbmr32211a12.6.1794876534067; Mon, 16 Nov 2026
 16:48:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116223033.3866283-1-ma.mandourr@gmail.com> <20261116223033.3866283-2-ma.mandourr@gmail.com>
In-Reply-To: <20261116223033.3866283-2-ma.mandourr@gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 16 Nov 2026 16:48:42 -0800
X-Gm-Features: AclHuK8u4qyvtWd_l0Y2lGLA_aG_TmvQh08Mtzu-tbiyDdt1Gk86PTeZCcQDyUo
Message-ID: <CALMp9eTsfGjGX6rmYYv2F8sth-WS7LPTe7UQ7aMZfFi87e=eLg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] KVM: nVMX: Fill VM-Exit instruction length before
 saving pending event
To: Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:30=E2=80=AFPM Mahmoud Abumandour
<ma.mandourr@gmail.com> wrote:
>
> Fill vmcs12's VM-Exit instruction length before calling
> vmcs12_save_pending_event(), so that the length it saves for a software
> exception isn't overwritten.  Commit c3634d25fbee ("KVM: nVMX: Leave most
> VM-Exit info fields unmodified on failed VM-Entry") moved the assignment
> after the call.
>
> L1 sees no difference since both lengths are read from vmcs02's VM-Exit
> instruction length.
>
> Link: https://lore.kernel.org/all/sashiko-outbox-179791@kernel.org

Sashiko is wrong. Neither of the scenarios it cited in v1 holds:

  1. After vmx_cancel_injection(): if nested_run_pending is set,
     vmx_check_nested_events() blocks all nested VM-Exits (and
     __nested_vmx_vmexit() warns if called with nested_run_pending set).
     Once vmcs02 actually runs and exits, hardware copies
     VM_ENTRY_INSTRUCTION_LEN into VM_EXIT_INSTRUCTION_LEN if a VM-Exit
     occurs during delivery of an injected soft event (SDM vol. 3,
     section 30.2.5). If nested_run_pending is clear,
     VM_ENTRY_INSTRUCTION_LEN came from event_exit_inst_len, which
     already came from vmcs02's VM_EXIT_INSTRUCTION_LEN.

  2. After KVM_SET_NESTED_STATE + KVM_SET_VCPU_EVENTS:
     kvm_vcpu_ioctl_x86_set_vcpu_events() never updates
     vcpu->arch.event_exit_inst_len (struct kvm_vcpu_events has no
     instruction length field), so on a reused vCPU event_exit_inst_len
     is just stale junk.

Moreover, L1 *can* see a difference, and this patch introduces a subtle
regression for SGX enclave-mode #BP. Per the SDM, volume 3, sections
30.2.1, 30.2.4, and 30.2.5:

  - A #BP that occurs in enclave mode is reported as a hardware
    exception (INTR_TYPE_HARD_EXCEPTION).
  - A VM-Exit due to an exception encountered during delivery of an
    enclave-mode exception still sets bit 27 (enclave mode) of the exit
    reason.
  - "If the VM exit occurred in enclave mode, this field [VM-exit
    instruction length] is cleared (none of the previous items apply)."

In __vmx_complete_interrupts(), INTR_TYPE_HARD_EXCEPTION does not update
vcpu->arch.event_exit_inst_len, so it retains whatever stale length was
saved on an earlier soft event. Because vmcs12_save_pending_event()
checks kvm_exception_is_soft(nr) unconditionally, it misclassifies an
enclave-mode #BP as a software exception (a pre-existing bug, outside
the scope of this series). Before this patch, prepare_vmcs12() at least
overwrote vmcs12->vm_exit_instruction_len with exit_insn_len (0). With
this patch, vmcs12_save_pending_event() clobbers 0 with stale
vcpu->arch.event_exit_inst_len.

AFAICT, there is no valid path to prepare_vmcs12() where
vcpu->arch.event_exit_inst_len is better than exit_insn_len. Can't we
just drop this patch and delete both vcpu->arch.event_exit_inst_len
assignments in vmcs12_save_pending_event() in patch 2, letting
prepare_vmcs12() be the sole writer of vmcs12->vm_exit_instruction_len?
