Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC7223DC6
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151360; cv=none; b=mfI8J1ooWuKJIP68fq0trPEXlNJ0QSa5DTqn+wyppMLactWBpof89XPRE7vVX5KaUMjvngUXITR8Qjh336Bj3aw8mTlKkIqracREFzGuej8YdUFBFrkO4tDbWXaWQcPiiATgehSU0yNKVPvBmoGkQVhkVbVVV6AVpkl8EigIa2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151360; c=relaxed/simple;
	bh=GiB4NgaSW9wzhpzOctOgrRLGNPibIqPgLRcvSh4cIB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cGZtm9CQEno1brhcR9CQk3L6HbnyfQCEJkRpF6s5Ppo9w9qgKdyWI+TRV5WdjhUQ+c6uKJV6YzliXgy8v9qxrJugLDyR1dRdY/FhLW8gn6nAEHqs3ER5hnuK1/v2+cb7uxzt0YcR/XKSb0i3JG+pE7PobzF8GTbTmWPFC6Lnbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnR7zT1E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnR7zT1E"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd5b20aaa6so32599455ad.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151359; x=1779756159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8bS1JIyLf3L74nyvyziIuw+0b9p5Mm/yLMtr7KTpLA=;
        b=ZnR7zT1EPWrh7kAGXvYKV9ivU/0+qBCgPoJNy4bW1YnvM/FQChHJ/VKEvYQdu4BDua
         3OWlqQcT8leMotlw3U83coG/v38gxdhuaOthHd6FR6382CVPcnjJjhzp2GMa4hw+Aimi
         Ff2w36GHWVHbMqRMQGAsNneU7P22zZsaXYPJGXqdV/K1Gn1hDWcmx7yGP+GCEwmWtzIn
         +HZ//EypQ4AUOWXImJEEx1fRF92Yfz9RroERJUcyy/DrDJfySMZI/PgC/smOSEoBLKsA
         Ukh+qTuU7Amcu2lqVdw5odsk0hBsm7ynKRm9wNSys1l1QkEVHeE9K5es31/SujgmSKKZ
         FUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151359; x=1779756159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8bS1JIyLf3L74nyvyziIuw+0b9p5Mm/yLMtr7KTpLA=;
        b=cbm8OMuhCK6q0lpwJNg3iXfovjkxv9S9Ijr6//GDYm08P5O67eXyT1ahqbd23VD2yS
         YXJQz+7GRw/h93tYL+C0HrA2cYUR/jW1S8PPei77NCsMS+Pl6myxbD1VIzU5qa4mN5w4
         Bmq/KheGGSCRdmvVmRxIYae5CRre11Q6/YJwvvQrSd0bevuSFgmKpt+ljxY8w2KJs+N2
         CQPcalUdy06UVI6n8j7XzEW/ksY3/8s97y0+YANEP+EC2GTl30TYWbQ18azNaHWOkH1y
         tC4fBuay0yxYHlUgr6NRizB6kYKk0g29uIIfe8AGZnF8cxEooGuqv4bBvK3LcK03Pcrk
         elFg==
X-Forwarded-Encrypted: i=1; AFNElJ8Vl17abu/VlGgjX4dQxuNdSI4O37fM16SPVVswK9eFg+EfyVl1xLRNhuKth+kqr7dwTrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj//40TPtzp/VnPhgR/LpXoncpGHIxotH70mrgsh8alv4CMqMW
	bNnRqoP8oLmg6SL/PIETPng2W0V0XaDJtLRDb+CbliuPe8aQpRkryTe32qAihJu8tPNv+5Z0vvY
	ZlRgP5A==
X-Received: from plbmc15.prod.google.com ([2002:a17:903:2b0f:b0:2b0:af76:bcc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c06:b0:2ba:73c4:4a77
 with SMTP id d9443c01a7336-2bd7e8fcbe3mr181361435ad.9.1779151358945; Mon, 18
 May 2026 17:42:38 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:44 -0700
In-Reply-To: <20260129011517.3545883-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129011517.3545883-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915048117.2225067.12213687050498218442.b4-ty@google.com>
Subject: Re: [RFC PATCH v5 00/45] TDX: Dynamic PAMT + S-EPT Hugepage
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sagi Shahar <sagis@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 28 Jan 2026 17:14:32 -0800, Sean Christopherson wrote:
> This is a combined series of Dynamic PAMT (from Rick), and S-EPT hugepage
> support (from Yan).  Except for some last minute tweaks to the DPAMT array
> args stuff, a version of this based on a Google-internal kernel has been
> moderately well tested (thanks Vishal!).  But overall it's still firmly RFC
> as I have deliberately NOT addressed others feedback from v4 of DPAMT and v3
> of S-EPT hugepage (mostly lack of cycles), and there's at least one patch in
> here that shouldn't be merged as-is (the quick-and-dirty switch from struct
> page to raw pfns).
> 
> [...]

Applied 1-4 to kvm-x86 mmu.  Please yell if this was unexpected in any way.
I'm pretty sure this is what we agreed on, but the last few week have been a
bit chaotic...

[01/45] x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's 0-based level
        https://github.com/kvm-x86/linux/commit/4487492b92a4
[02/45] KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on mirror SPTE "fails"
        https://github.com/kvm-x86/linux/commit/02eaaffdd865
[03/45] KVM: TDX: Account all non-transient page allocations for per-TD structures
        https://github.com/kvm-x86/linux/commit/a8b2924676ec
[04/45] KVM: x86: Make "external SPTE" ops that can fail RET0 static calls
        https://github.com/kvm-x86/linux/commit/e1a31ca28c9d

--
https://github.com/kvm-x86/linux/tree/next
