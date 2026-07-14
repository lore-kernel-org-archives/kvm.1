Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EF377A8F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054596; cv=none; b=sIRurnpctbvyhAuDTxEDma/reL2l1KgDAJDspdVcMH4HrNa66WBZjMvcLw47oTYX9mwP8Ix5f2Qm6/NKU63imemgRwmJWE4AqseISVTcR5gmLZdfyIgy5IDcnOnMr7c3T8Bdi3Fc9VAJ9IdRqFMl+aScwRtH3xG0e6ry5zuA0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054596; c=relaxed/simple;
	bh=QMtboOij6SiylMyty5zxOifbocl7KL0C8wQdf1+7zio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tT65jNCuUyKBtCZd3xHWdmQLEAngux++2ItXK00Xm2zWkT1UciZRoqVkX7wQL/ggjR+JBoUcjd2L+fuMu/hrEPwudlm9iFEwRl9ryWp3x1GllnqV5kO0d/0jzQ58lysgvYbBmznvsmLEM+RF+f44jzy5gzBeXwBCEQDCJb9cz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vS3PrwL9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vS3PrwL9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88ab059052so1468485a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054582; x=1784659382; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8a7Ma3SWbuWG4d5N6WsHS2bhQ3Z4xI82D2YlDjqK2yg=;
        b=vS3PrwL9O93UhSRKW2/+GkIkRt0rFPZ24ewFqjz2pNmhT/sTheqMuuc75myRi5uzVB
         hE+S5JgSFSo57HjO39305WTO1TyJ7sV+TvKKgtI4k+HbNti9lf9sIwN8wXyCCxzHO7tp
         qxgkYXA4GS3qpLglFUut4sEyTEqySylE5hroAHmcaaT7S2fG6nTzMx7+vLXvXOZQ2VlG
         V/JDl+N3fa/Rvqrvcg8DuFlDfuseGnPzHgp8XpJp0bufvNMFKvqZGjFieEV/YYZcOq7y
         l3vMxtN8N6q6EEa+bUb1qeOYf/CQXq5pytkfKLU0Dt3wbdfcMKL94YSYkrScwRbgRTrz
         pVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054582; x=1784659382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8a7Ma3SWbuWG4d5N6WsHS2bhQ3Z4xI82D2YlDjqK2yg=;
        b=omPgtsseavwb6QCZuO0FyFf8BWI6m5Uxtx9v155jReQECbpuS0NJrBAW8tD/cAzvbD
         hdTV/xZ3bzK6OhCgA+oCppuY/PwZIgXwKSAlg7+I1El1cuiMlTYEw/VhSOXN7j0VRofz
         z9NNaiR6lL1yfXGRpRQXYanyvXSCC3bz7INBLIaDZ+r8+H2l4ki6kWXyMB1KCfo7GL2o
         2ql/wXLyjMepGNYMBUNWrGTKeuUlLwTnDX3ScV9lxrKAr0GX3/P3osEKAkLhneI33392
         X9wJulwQD4bd8Eu7uENtcm4Bhv1fzBN9RnI2PeVo4vTn2ospN7Gc8azTo5spGUTYTgMc
         7P3w==
X-Forwarded-Encrypted: i=1; AHgh+RqGoEfSmuI+gBAaA7gzARSAGVjnQOrVC27r4+7Z774Fl/tfQ7F/aF3/omVGl48QQmMB+Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDYx+F0XuGkukgHycerCDjhteaaqK2kQjrIw6dRgKLy7Sxwyq
	BliJgV/xA37eRBC7NcRoUIvkiYXramWkDFMknadurDZ+9aYYjrbamfFH1UAiEtmfcYoYIKik8L1
	UXcM8IA==
X-Received: from pjbqe4.prod.google.com ([2002:a17:90b:4f84:b0:38d:c157:c023])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3901:b0:37f:d265:18d2
 with SMTP id 98e67ed59e1d1-38dc81b0ec8mr11584484a91.7.1784054582147; Tue, 14
 Jul 2026 11:43:02 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:05 -0700
In-Reply-To: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405257201.3111763.16358668642306263283.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry count
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kas@kernel.org, 
	rick.p.edgecombe@intel.com, thorsten.blum@linux.dev
Content-Type: text/plain; charset="utf-8"

On Fri, 10 Jul 2026 11:53:23 +0800, Binbin Wu wrote:
> Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
> initial read and the subsequent copy of the initialization data.
> 
> tdx_td_init() first reads user_data->cpuid.nent to size the flexible
> kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent,
> and that field can differ from the value used to size the allocation if
> userspace modifies the input concurrently.  setup_tdparams_cpuids() later
> passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
> the array bound for the copied entries.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: TDX: Reject concurrent change to CPUID entry count
      https://github.com/kvm-x86/linux/commit/cfbebb55e512

--
https://github.com/kvm-x86/linux/tree/next
