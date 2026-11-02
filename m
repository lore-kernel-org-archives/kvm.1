Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793662777;
	b=a7cTqgwrmuaUP5HygHK+w5ywHfVnVMN7DdE3G915qc5KAFHMzwjfSOylm70urWO5Iqgd
	 wuJq0ifc7GiXeEx3bCcypnhI3BrLhU0r5Qy3utKExuJt+ox6mCFTdkS1pKgeLytEmuuNN
	 CJJPNT5XTzzmPkLX2p/+a3lsYzOwwtchTaGscHhSbmvxf50GFZfUss1zcxo5coFzSEmTH
	 Ja7ngpfYmrbTi/IYxdrG+5q5BVfvz5eKMP/PNm9vcKlVaYlMSDOP+5a0zblFocEZ7C9VI
	 6jqGgmNOngvNbAW7tIRgDkwr5IQxvMXyma9GJLxwu98Ye93C1Fwew+bPn88HjoWltqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
	b=WvTCvdH7KS+DF/jsnjh5SmNJqvdA4kgk7+bjO/hqp8rWpLHhk3zv3XoE1dHXf1AbVMLP
	 vgqpXePYKhwkJwrawaaitHYv7F3l0rpvH+fpWC6fpFWb+FDyF03a50r5+FvVhnrpr6hTq
	 ZNcVkMhxgNQ2ZPxy/7nmpI20t9bLhrtcpmq2lxr1LmGm/EpK6Mm7YwAFhH1EYZKyZQ5Mi
	 H1dtbSCb0/ORQeBsCjeP9r9VlBOZOWGwc5Fs5KoI5h/8uRn3u8j4H0w8fY3JjV+CMxqoN
	 MWg2h/t6IFxOEuR6flRplrAmj79npoEAIML0vehkJGmvEqVxXVfrhVHVdosOipi14Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XUVIaN0k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0B606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F0B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XUVIaN0k
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so3813a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 15:39:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793662775; cv=none;
        d=google.com; s=arc-20260327;
        b=WtRywPd1ELyWXSbfsZJsfsyJbzKQrK5wSFegfX8U9U4jrg3Bar6UfC07WqADeKmPtV
         TWWI1cGtGRx+UjGuxiITiec2cmVJBtqDDInNWEZGm0lljJuNFEOoJqDl+GPxU8DyyQTv
         /xGLDLASTNhVjew3HVz7M6nMWo0dgIw9K+lVGzmMRe9gID+OiqYZJJ40nGA8pK/wrxAq
         dzn+oS1w9EAk98mKhCgWnbLbbuEmQIkGLOu2kc9+bm1ttKV4fUgWgmFEI+Kv1nIGQTSw
         ThTlB/dw6mQ2dJ9CyFGFryW6qO4/bFr5fnd4flsuBB7Ql6uW+vMDUo1JsTOm4eZkivzV
         hWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
        fh=b0hTt2Bc9xBsY+TIIpWF7KpGl3umGBJ+5YrH3lxqyTE=;
        b=on6Ho3hOURaOWjYtVDPurwGZ9tYFV2UeiD4Tx3RuifrcX0SZ3vuHBxY09SNkHQwfuy
         9dhChCuHgZP22G9T6EyIJhLZvIP9Sjq0xGEILDIwzx/JIWUOxnBhfoNkp2nqi8jZ1GkP
         L5UiryJZVgphgzYnwBK75njJVns36U+vFoukIR37BMbAA0rfkuT4OJ142zQvKYbDMcNk
         7m3OvCsvJFUvVzJboiVaGc+0o1SBt1mOAPHGQaCJ9/kjsLTROU9lfgszRi5bTBzzGtSt
         7idFy//dVM15BJEd/gJlWkTH3WNQQM4DbD9O+Dg2kXyGWZ47mdlIvWR2aaAc3cSe5AGy
         NSkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793662775; x=1794267575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
        b=XUVIaN0kG8xdtu5h2ZGfO1duG7NUeb3NlnGwuDdCm7+GDP4sti5i3GtIgh/wGANS3v
         iLG4FWeU/XVJ6RmDWvjMsWFVP2ETCkzWNm6dvkWqmBfIMStsQjPPeFKt9onzqxRkV+9n
         SZqobE0JlV574RoDGd+Fk3S5HJchvZj1nbns4BOgjX5kWZ5+GqfI504FWg8QCZ3CduVA
         txlnmutgVLylcu9Kvuo57PytOMdh+52MKoLswapw8HS3LbMVWaZ+aOYTma39FPnOIL3v
         aolVSsmSvffPjE/n/j/IztRqZzgXtwiE2epckEY/tLPgbodm7hh+EjAE4BoQUwHS5z0y
         K9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662775; x=1794267575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
        b=cZl7ts7vfsWU1zeoupeLhR65hxnuDq8KcKMir8vAXpLLDExKnYtrNJ2qS//ajgdiiG
         Lu/noxdrl4SHTmJaVDD0XckrhVU8mR9K8yXkgJsLA8a526xUL7/tR+W4KKyF1fgIOrwQ
         DiFV3iqQJNPfZ/Crv7E1+pjpZTD/dR81O+djeDg9ekgMWP04CH8Jm5qSeWFyMpFUWNZM
         s8UUz4pFqOyVYMBf/23+7IyXtGpsSZgZjJuO0MX+XOkIfCr2k9TmZ/4oX02EEGbGDLbm
         KuTtmagGfQ4+8Nr5VHayXP6+7kmWMXGLwiYrMzlWfT4ov+Ycc8Z0I7sSLcwZKdFV19tt
         inmA==
X-Forwarded-Encrypted: i=1; AKwUvBx5cUl3JDnSAXV5A52llrx1bCDE9UYl10pVoWG3ypiAN2XD4IFxbVA4x9AwvyLq4aYk/Wc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jqExnf4ozGi6+VkaP7dC7LvM5rEXqWy7tLkQe+xWkRW+PFV4d
	TMJLJ07Bfl2J2RnX89lYYP/UoIesTOLx/a0VgJU4UNbhycIDvCaQh1tgbJOXGrO/c1ZqQd2EGUA
	3+WCxnqLdb4425gJqTxTd7eYN6a1JHLBFC7MeIwQ5
X-Gm-Gg: AYBFou1mv+6jmbNDDjfAndwnf5MA5eVzS1jHjKEjSl2H46lR4qFwnFAO5HlhXWqn/3q
	v0/pxwwHOZmgMX+BKmGmaYL6mwGpf9NT4ByodJmaJJFya4A460dxwriOhLjm32gv+7yS2RlSlde
	3j4wlRen6NDmwAJpKBfW26wAxh0r9AMuoz+Gi3zEIgTB3rl4sOYT90RCqrqNWg8+MKCjmF2JadO
	DTzg6kWcrLcEt6omGy8K8/NdSCE6ITPJk7cINYvuGRzOFITSKNOT8ji7Lo/7KvJDAqR4E/GeKfk
	Pn40Y3MeAmjOoRoAD/0eCLbDXlkhlZC3bsbUetHUFhi2C6rzU9OC4M34O12ifBbTJHt6vj/tcMd
	feRBAJNDHxkQgTpvy9dFxRgj9j4f0lB83gO0a
X-Received: by 2002:a05:6402:10c9:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b53e764c47mr10361a12.10.1793662774603; Mon, 02 Nov 2026
 15:39:34 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-5-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 15:39:22 -0800
X-Gm-Features: AclHuK_llZQOnCwx54tZ59oMjrQu1r-_j_89HC5UjrdUh8dhwsQ0SoPYuUVmetM
Message-ID: <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add a missing "break" in the inner for-loop of the open coded mess that
> unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM-Fai=
ls
> due to a consistency check that is caught by hardware but missed by KVM.

That sentence does not accurately describe what the code does.

> I.e. move on to the next MSR in the VM-Entry load list after performing a
> write using a value found in the VM-Exit load list.  Processing *every*
> matching entry in the VM-Exit load list makes the processing quadratic,
> which is problematic if the load lists are full of MSRs that are expensiv=
e
> to emulate.  E.g. writing APIC_BASE triggers kvm_recalculate_apic_map() a=
nd
> a whole pile of unnecessary work.
>
> Functionally, arbitrarily restoring the value of the first matching entry
> is "fine", because none of this is architecturally correct: the load list=
s
> are never supposed to have been used in the first place.  In practice, it=
's
> likely a moot point as no well-behaved VMM will have multiple, diverging
> entries in the load lists.

This isn't "fine." This is disgusting.

The assumption that the VM-exit MSR-load list will "undo" every
assignment made by the VM-entry MSR-load list is misguided and wrong.

Xen, for instance, puts SPEC_CTRL on the VM-entry MSR-load list, but
it does not put it on the VM-exit MSR-load list. Instead, after a
normal VM-exit, it restores the host value in
vmx_asm_vmexit_handler():

        /*
         * Restore Xen's MSR_SPEC_CTRL setting.  The guest's value resides =
in
         * the MSR load/save list.  For Legacy IBRS, this flushes/inhibits
         * indirect predictions and does not flush the RSB.  For eIBRS, thi=
s
         * prevents CALLs/JMPs using predictions learnt at a lower predicto=
r
         * mode, and it flushes the RSB.  On eIBRS parts that also suffer f=
rom
         * PBRSB, the prior RSB stuffing suffices to make the RSB safe.
         */
        .macro restore_spec_ctrl
            mov    $MSR_SPEC_CTRL, %ecx
            mov    CPUINFO_xen_spec_ctrl(%rsp), %eax
            xor    %edx, %edx
            wrmsr
        .endm
        ALTERNATIVE "", restore_spec_ctrl, X86_FEATURE_SC_MSR_HVM

After VM-entry failure, Xen executes this code:

.Lvmx_vmentry_fail:
        sti
        PUSH_AND_CLEAR_GPRS

        /*
         * SPEC_CTRL_ENTRY notes
         *
         * If we end up here, no guest code has executed.  The MSR lists ha=
ve
         * not been processed, so we still have Xen's choice of MSR_SPEC_CT=
RL
         * in context, and the RSB is unchanged.
         */

        call vmx_vmentry_failure

KVM needs to do better.
