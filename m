Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E43D47B8
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260046; cv=none; b=rYl6bJfnGgv5ZD5feu/Gwo0Sb7swnfsXzurr9yXUjIN5HZxhdyDxcsI/jQ4Scal671JN6pXB8RmR4skdJgvpZlK+fYlTkGd106M/9P2NhaQslRD9S5bFC3Ge8gRWTutsQAX1foNabsT62p8uJsgQUZLaxWgpVYzqFHaYBg/ttZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260046; c=relaxed/simple;
	bh=pKt6udb9DhZCDMm+rSwFv7SSGEk0dYmbtaPDi5R1FUQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QFVROI2kelgM1Zn6q0X51j2K2PIrYc3f+Vvawxj4UD4mEp6/Q9v9SlbPoS7pSqW5XTAZVn4PNsdC7VsHjgSjWsZqHQyVk8dtp521tqmhMUnsZCNkgje05cBQNBj4p7FnXXfcU0QfJi3eq8JlUWOWvXOZyj016n2L/cyy43xaL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFcqrZhW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFcqrZhW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so1275368a12.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778260043; x=1778864843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQTZZvEcGTueFWxImFGRAerEmmKKzoQOK1gvnU54pxs=;
        b=IFcqrZhWXqlEoQvyuOvOEazT7kR7wu+miIsjaOspoW6YFBEnw3kqppeVEop/1MI5vu
         URcYs593vrrvBXZxJtLhLOSla5abpyTai2mx1AS+iDqIAeBePyTZ//UrT+KK2tf/P0Z8
         oex2I5ecY2mCHuc7nvCt0N4Yw866GTfEbrfz3YVswzNUeiZC5yNiwiTOz2mDMcTPorvx
         6x9zi6UnzTMfCSY225qkRMFMGabAEeusmmZgKl7SqlFEYK9eO0swZ7xiUJnQsOXbiU0f
         nS+Xi3B3LkYhfeeVQPLvYeumZgY4495O/Oh+Q23HZ1NsRE3o9yynshiLa3C+Xuxmvax2
         Kv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778260043; x=1778864843;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQTZZvEcGTueFWxImFGRAerEmmKKzoQOK1gvnU54pxs=;
        b=R3w2lKpCHoSe3EMma/ubF9qVGtqyT4lPgBJA46ED0F6v2ARifMIAJUVwDdgIeKlRru
         JLfdo/xpuxiSqm+TwWJNmYaxqsfemTLdC5QEWBT4IZVlkEYV4sktNFGYXo5gYL3TdGXZ
         dOeCd0Rsd1/tv2u5sdOWxjaloNc/SZXC18lBmGy7st88uyNgeU0t+l+OXiX35860RtY6
         dzeB1IPmtMFkYNonEWVkmOdvzOFR7HkqXAF1QJj4ukgY5yKVzNaak0WjWcbV8iFQzmZw
         +ZFQpgoa3Mg25voIWHFniUmhV06yLPB9OXZ/PryFx63N3nSf9Wzr1v0EfZ7Mrc+37Nu7
         2xDg==
X-Forwarded-Encrypted: i=1; AFNElJ+tOre2OBKrvtjNIqPYp2QK0iBxQym1K5j/WY3XBQLSjnL28FQc+nJ7yG9DTfOSMs/F4k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwSim+Xv4mLlspGQLdeUHKtMhtF26DsU4qrhQdqx9s2m/hzM+
	BsnNO+OS9eDHoRgC1OmZP5y88vVMkWtBoW10eaV1iTYIpcST41k+xkhQXIoyfKuulBakeSuHzdm
	7bwa5NkXAz1vt7A==
X-Received: from pga16.prod.google.com ([2002:a05:6a02:4f90:b0:c6e:1ddf:c9ec])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:339e:b0:3aa:ca34:61e7 with SMTP id adf61e73a8af0-3aaca346b9fmr810456637.31.1778260043030;
 Fri, 08 May 2026 10:07:23 -0700 (PDT)
Date: Fri,  8 May 2026 10:07:01 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508170714.489136-1-jmattson@google.com>
Subject: [PATCH v2 0/3] KVM: x86: Virtualize AMD CPUID faulting
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

AMD's "disable CPUID in usermode" feature is analogous to Intel's "CPUID
faulting" feature, but it is advertised and activated differently.  The AMD
feature is advertised via CPUID.80000021H:EAX.CpuidUserDis[bit 17] and
activated by setting HWCR.CpuidUserDis[bit 35].

Add virtualization support for the AMD feature.

v1 -> v2:
* Remove supports_cpuid_fault() instead of renaming it [Sean]

v1: https://lore.kernel.org/kvm/20260402223108.650572-1-jmattson@google.com/

Jim Mattson (3):
  KVM: x86: Remove supports_cpuid_fault() helper
  KVM: x86: Virtualize AMD CPUID faulting
  KVM: selftests: Update hwcr_msr_test for CPUID faulting bit

 arch/x86/kvm/cpuid.c                          |  2 +-
 arch/x86/kvm/cpuid.h                          | 11 ++++------
 arch/x86/kvm/emulate.c                        | 14 +++++++------
 arch/x86/kvm/x86.c                            | 21 ++++++++++++-------
 .../testing/selftests/kvm/x86/hwcr_msr_test.c | 10 ++++-----
 5 files changed, 32 insertions(+), 26 deletions(-)


base-commit: 85f871f6ba46f20d7fbc0b016b4db648c33220dd
-- 
2.54.0.563.g4f69b47b94-goog

