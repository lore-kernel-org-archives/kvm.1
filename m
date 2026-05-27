Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68347B420
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905681; cv=none; b=tJVRmuuRcqy1u54yvPFjtJg9Rrl4fRNZ+dWz+YCE50H8Oe9MrBjK56l6vFjPdqG2/f7aGo2EUIPCaPq4cEVj4Q0dr4rsWOa9++CYXAJjjgQelZHF0En+vdR+nnYCgC2afOxJoEgpR54EyEXBcpcNxYCnUVlI1fVQIJVw49b5UgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905681; c=relaxed/simple;
	bh=rLnY/r9Ruahq6JSCM4QZVx42p/ohIgGGx2zoK296gjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6Sgl5tfes1RBS/9AS8JxUiu1ejidOkmjyhD/JGRjhbfmEiswvThAPvqtvy6zNDCW0wdHGJsTvkg/7zEG81egbvf9z9IAFgBybowmSdl2auslq2fga17SQVFtD9s0NhkR1w/cM2SaOxh4QRdWNw5AqgQzninRWtqcIGWlR1ulMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2pSL1pv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2pSL1pv"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso5348807b3a.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905678; x=1780510478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ae0JUYZnH6PDq++BeF1nOUuxoe4YC/dX1lDQosSPY5o=;
        b=O2pSL1pvDX8thkRVNHwtx6tiCGHu46WFdXGzHz5pYVytNpdFmXhhiMNldwVvJV3QGp
         AL5BIifeaTuu+oJ5+uHRAp2i1gvfBnlMSpBT1Tcuf/bz4kKcDxohNgjzGIoxOLQCgMsR
         zC5d1HAH7/W6GHWfCQFWejWhVTgIdIA+L5uaHV3HAdLzB2pDG8BmIscKRk7yJ50Xu/kw
         oE82qcnpdXsNA9ZrwQbQ2z40JxvaQKvVBdH6Y4k+DQXj88nDzhq4oVrbMTyqWT6S0BmE
         /oWHnCN0eQuMl9uoZbDgyfGW7Enko+zfzo7KahgXcvVMBbDJdwet2ZqA6jINjDdoz/CG
         a0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905678; x=1780510478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ae0JUYZnH6PDq++BeF1nOUuxoe4YC/dX1lDQosSPY5o=;
        b=Uaz//VSrCC/Z620aCCUUBpG/7GiBdG3D3yeL0najgjEJumU5mzRO3YA/sx+FN2HRX/
         l9u6IU7M9PVc0uwbEQkdhqgF3EBv6wSqh2Nk65lbCh8CViQLLDChFonwcmgHU6AFnBF1
         MlsUDTevWhmA3GtwHIYITxhhJTaKArzxX6tlgRnYngmliNrvxjVc9cYZi6UPWxvlXz51
         0oKkDWzKvT++UnYykv5cm+/BrXeem5e3Ln33xFG1GlE156IZNXwCsF5H6cs1lWdzLJ0i
         s/H8PF+ubLG8L77VWKtalES/Y1DcZWrDOjOLr8dukyCNHlNq8yFrH7OrTvYzkm47faju
         HXdg==
X-Forwarded-Encrypted: i=1; AFNElJ/PSl1Hva4VsxxCgGbBV/Y54HNDkA/ubGNYH7Z6kXGdNKZRbm545iQ0sSgxil4k2aZz7Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4pYp3cN8xQcoGxB5zK7Q0HQMBniseJDePToGnKG34bAyXlDG
	EkYTY2j/SmoaOlSy9oJdlIpBzgJqZ0vrsC/9/NfrQoFAAsoTT607L9t9sQQ1UcK0qY+KdShT/GX
	ECh7oGQ==
X-Received: from pfbey25.prod.google.com ([2002:a05:6a00:38d9:b0:82f:4183:2832])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9084:b0:83e:b443:965e
 with SMTP id d2e1a72fcca58-8415f2dd96amr22258784b3a.3.1779905677512; Wed, 27
 May 2026 11:14:37 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:14 -0700
In-Reply-To: <20260523111857.195396-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523111857.195396-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990517478.4120439.17004463221573645730.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: vkuznets@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 23 May 2026 13:18:57 +0200, Piotr Zarycki wrote:
> Writing 1 to HV_X64_MSR_RESET triggers a real vCPU reset; the test
> was writing 0 because the host loop was not prepared to handle the
> resulting KVM_EXIT_SYSTEM_EVENT. Add the missing handling and write
> 1 to actually exercise the reset path.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET
      https://github.com/kvm-x86/linux/commit/5bd0387e3b56

--
https://github.com/kvm-x86/linux/tree/next
