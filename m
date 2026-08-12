Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A404486B91
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570341; cv=none; b=EYL7nGBqExlS8LP9ezunlH/EGoUyln/yGa8Ua7o+fK8RcQkEt/JfmaRUcC8HCFnpvLuaFRPNM/7Bx9ftTljbmJRwpVhbuSn1rWw6E6WadGDQRXsIcgwgxFjQhTBOK8ZtAUYgjx4PND6NoG9Q1o5zYunUvrjPhb1ibl3m9IkPrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570341; c=relaxed/simple;
	bh=WPb+oNCguq+D+nsPzsQHeXuOUkU5lLZuneD2Dm6MSSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bVwRGos6tzRoCZ7rwIjEuR9r697YiXneH+oWWCI/dwiJRjb0KeCSjZGY9IBbx4JdREccjhyT7egaO7FvdpdyovkZoqE+x1cNk5j4QQvc8aVp0GQheOd/8/pD54fx8gj8NZtKUiqkW/EYm92aukMY2pnY5EVHZlVl9gXF1uxjHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/h70TxK; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/h70TxK"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7621655eso2166351a91.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570339; x=1787175139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IQRjHeJHDNL9dVABA640wyJElasdD4QcDvaWcZI2PI4=;
        b=q/h70TxKMXcaaFEjrdmXCNROcXJZ3YE19A09MgHhijDDtdYS0eopgUIPZ/XD9sHQ36
         JhiImmNQQBkAmClWRQisaobgVjaXJU90NOUsPi4+/0dlyAfvvNCegrUa5EL5XwrbESV3
         uU+1apI1BAks5oq6pcM+pubsxhFtoFV/ehGwHAjYSBe5LD1+pqGDds4cLCwYqzrJamDZ
         1AGt8bWLT89ijW1OwQjUyZh+0mJiAJomZvKikc61o2i7rx8r2wXcedRzXz4FYHJJQY02
         rsflTlU0mScUfYxRtqE402+/vtwMnC09r7jZhaimenUSYhQPXvYuG4V7zD4bWuJCjXc0
         O79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570339; x=1787175139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IQRjHeJHDNL9dVABA640wyJElasdD4QcDvaWcZI2PI4=;
        b=p9kdmercZdkCjozO72DXydtAvk6/RzA7R0vprxEDv5XvbdFqRj+KOnULFdHWko1Eki
         LOohCHqHkFFfR+4pQ1abZxr8gDirJzfvOpbUidNjjPiSLtduTqUFdVZclyK72DD1LR1P
         y64EODqHrcY/5QrLXT4d79xO43hE0Tbk2exTdu1J8KuPjGBQYcRWkOX0F4tvOhgCy3c1
         imhpIpZjn8YoiEneOvQtOEPywRb6/7rflhNkAbmJbtpPp8C0HlvWx5+dulhGQaUFGh0U
         5OfCbRcr+OSPMIAhZcXpZHOTt/zG1Wh0eo1zPZHZCJx4JMl70l+pS1afGSF4V0ZqKubj
         qXjA==
X-Gm-Message-State: AOJu0YzC4eWP5qH6utqFN3uMek6Gyn2+JJcDtjDYwLfH/4J2X23sSPcM
	fcKqvj00I4DYklc6nrBuJiUucnpO/9IG/H3sid5KnhHzM/GATAWKZ07zl7I6cEhM4w6v28+4LFj
	ppaMP4w==
X-Received: from pjbfr7.prod.google.com ([2002:a17:90a:e2c7:b0:38e:7e4f:b5ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580e:b0:37c:18e0:90dc
 with SMTP id 98e67ed59e1d1-3931e2537dbmr1495915a91.16.1786570338692; Wed, 12
 Aug 2026 14:32:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:32:04 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-10-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A somewhat random collection of fixes.  Note, dropping FOLL_WRITE is safe as
GUP breaks CoW for FOLL_PIN.  This is explained in the changelog, but I figured
I'd call it out here too in case you have the same knee-jerk reaction I had.

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-7.3

for you to fetch changes up to ec9a16c6aeba8e19ce98c58a1ac255681a4dd0ac:

  KVM: SVM: Always intercept ICEBP to workaround AMD ICEBP+TASK_SWITCH flaws (2026-07-24 13:15:14 -0700)

----------------------------------------------------------------
KVM SVM changes for 7.3

 - Remove a dying VM from the GA Log notifier list before the VM is actually
   destroyed, to fix a potential use-after-free.

 - Don't pass FOLL_WRITE when registering encrypted memory regions, i.e. when
   pinning SEV/SEV-ES guest memory, to fix a regression with file-backed memory
   introduced by KVM's (correct) usage of long-term pins.

 - Allocate full pages for SEV/SEV-ES {DE,EN}CRYPT ops on SNP-enabled hosts to
   fix a data corruption issue due to the PSP driver assigning to-be-written
   pages to firmware (as required by the SNP specs).

 - Unconditionally intercept ICBEP so that KVM generates the correct guest RIP
   when handling an ICEBP-induced TASK_SWITCH #VMEXIT.

----------------------------------------------------------------
David Woodhouse (1):
      KVM: SVM: Always intercept ICEBP to workaround AMD ICEBP+TASK_SWITCH flaws

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Qiang Ma (1):
      KVM: SVM: Remove redundant ret = 0 in svm_set_nested_state

Sean Christopherson (4):
      KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook fully AVIC specific
      KVM: SVM: Do all per-VM AVIC initialization during vCPU precreation phase
      KVM: SVM: Remove VM from the GA Log notifier list before VM destruction
      KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled hosts

 arch/x86/kvm/svm/avic.c   | 96 +++++++++++++++++++++++++++++++----------------
 arch/x86/kvm/svm/nested.c |  1 -
 arch/x86/kvm/svm/sev.c    | 29 ++++++++++++--
 arch/x86/kvm/svm/svm.c    | 34 +++++++++++------
 arch/x86/kvm/svm/svm.h    |  4 +-
 5 files changed, 113 insertions(+), 51 deletions(-)
