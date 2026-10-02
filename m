Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153840A92B
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975504; cv=none; b=BIzb1c2TLFWJHNQX+Vi1y7GL6Z5gRRtbPexOzNt6fwREXmKJkz2G8p3cQD0+2VOBTWJYgMLEv40s42Z/okGVTtZNyenmbm0D7tR6AQ82F1UJU6JXVUWNwkbh1kcE7lnAtPk0ntEbbMHiX3Gq4z2AZHCYymlCduhMRm9pDdzqZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975504; c=relaxed/simple;
	bh=m1kgZk/QnnIGSQq94ScRWI4VTjnRh3pMl09wcBzDj1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4WYXPo4SFditfR7HkfTArv5sMOHwkvGENa4WpZJC+SN1XS6TvCLnpYquGnbHTkiX3Lu8zNcj5iR5uDxNTFATAy6R1y3mBTebbWJRY946fhMiFOSez9MTHX4a3K6ZqANxvmKlM85ro8pztFLaps9yWxkh/4ygiYtqqZjbyLB3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TK6X8O3w; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TK6X8O3w"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4a053dcadso323915a91.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975497; x=1791580297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1MttPZc2WbaNxCbcw+ABVFsYx0hSjd1yRWWbDI1AxA=;
        b=TK6X8O3w7PHvfTxBzEn1xNRHM3zaQA0YonJesndJSXm5l3EYOZYVb36I3wag0aCtTR
         yiV8MdiP5y954sybPn488evw3nTJX/tQXObdmqInx6TMfB/Y1hgF08r3/i+7RmLFmWWh
         dxy88du+76jKfsWBJX+4TavxwtCIvS17ACWCEoBBYNR61cHmrpgLhb7i6MVhj/4RRLD8
         AZUo1rR8W7KMQkvLGtiExv4djDf32tUlI1k3e83t6gAyKbiOh81MIL3vpd3ssVqndRNr
         3XPSgTNELMc67v09FkhiMQEkFJgevkuOjrzPYte3/OPYPmiZiK7ghsGN+i86vDL60CZj
         hNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975497; x=1791580297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1MttPZc2WbaNxCbcw+ABVFsYx0hSjd1yRWWbDI1AxA=;
        b=H91oDn6x9ZkIyGuyTLLfct6XodYuGSXINXjZ/gNkqXHlKpje5++ue2q9TDCRKVWD4Q
         RTLM7OOdH6DyF0P11zs8bKa/hApO6S966LxX5JSLKp9/xG2QqPcoTMicQZrqhdJuThMz
         AJU93cKdx8+e6O3RQy5feeW51llrtW/wWWM2++W/BFZFZ1DS387gkQiM4jd6aeKM4g6R
         kibPCQjmLJk4FzTiBBB0N2N0Wt8RFiLsbjXakl3okiO6cVEQOxa+aIrpJ1mS1TUeKOrt
         WqSvob2ZlyBsJ1n13tN3k/Q4TxNo4G/gW7mHZZXofEsaFYnuugrgpgViquG8PqUrqTcM
         ZelA==
X-Forwarded-Encrypted: i=1; AKwUvBwXN2tGMSI9YaB0+bikdGyRUToN/In2bHZl5PSQuBEZREEKC04UbtJJV4Kg37+7kqHZzog=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8t6OjfkzPDt6el1keQHQXhfx8VFcdYS6yM3ZG17ZaOItGfJ9i
	gCamiwkPsQ8Q6wYTliUXP/qrOWB+DT7jsnRWgR8CsgL9le5yvNQFQUzXXebRDYXLJpVsvVbYyGJ
	nZcnJOg==
X-Received: from pjot24.prod.google.com ([2002:a17:90a:9518:b0:3a4:b4f0:b161])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f86:b0:3a4:adea:50c1
 with SMTP id 98e67ed59e1d1-3a6ced92fe9mr3693415a91.62.1790975496840; Fri, 02
 Oct 2026 14:11:36 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:36 -0700
In-Reply-To: <20260820123512.87236-1-duankeqiangcym@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097516928.4085781.4004685515336917376.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Keqiang Duan <duankeqiangcym@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 20 Aug 2026 20:35:12 +0800, Keqiang Duan wrote:
> Force a vCPU out of its hardware-tracked halted state when userspace puts
> the vCPU into any state other than HALTED via KVM_SET_MP_STATE, i.e. clear
> VMCS.GUEST_ACTIVITY_STATE if it says the vCPU is halted.  Add an optional
> kvm_x86_ops hook to do the clearing, as SVM has no equivalent VMCB field.
> 
> When HLT-exiting is disabled for a VM (KVM_CAP_X86_DISABLE_EXITS with
> KVM_X86_DISABLE_EXITS_HLT, e.g. QEMU's "-overcommit cpu-pm=on"), a guest
> HLT halts the physical CPU instead of exiting to KVM, and hardware saves
> GUEST_ACTIVITY_STATE=HLT into the VMCS on the next VM-Exit.  That field is
> sticky: it survives VM-Exit/VM-Enter and is only cleared by vmx_clear_hlt()
> on event injection, or by vmx_vcpu_reset() on INIT / vCPU creation.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted
      https://github.com/kvm-x86/linux/commit/883719f57f5d

--
https://github.com/kvm-x86/linux/tree/next
