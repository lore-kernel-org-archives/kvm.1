Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056931CDFCA
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480528; cv=none; b=Jz2wIkMFkD8rHjOfah4OrlzpgctIG7L9A/+zxylFhQnZaWOGLiR+8p6eeETKFYs2rWAnZpA1BBajoD4c7r13/L4YBJZ6yxFRpRPHp0eyZRBf1mbCr5mCh/2S9+oJ1NnI1bMvTZllh+pr+rm9/AxsNU7JivkBJvK1Gq2VxTiUDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480528; c=relaxed/simple;
	bh=eLnG4NV+OCfW0E5/z7fquJoe8Y23E5YJCg2MvT6naiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HwMQ23ckYuFHjyJvt7jtip4GAZkgY7zrXRr4cM5BvarIX2SqWT2OhqNxGtxQ2P2XC7meHMzMCRGOp4NF40wb13DnBS5EgsVmllyJ0v7SjmFZ3aw1qCGf9+dremJ/FWr6hdXaykjSJb87FT+gztuV2ADW2fvf8pXVS7DwVOUrFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNwFDmwh; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNwFDmwh"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso9200018a12.3
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791480526; x=1792085326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLnG4NV+OCfW0E5/z7fquJoe8Y23E5YJCg2MvT6naiQ=;
        b=kNwFDmwhOqTkNrAQIEr08+b8EAdk5UxgrQZ3y75W8dFycGNpd6NkmTLR4l0RvGwT8j
         w0Hw/8zUm8hpYrlnmLdNUdiR03d+y2ebjomKSzQY7bz1wo8D54yFZtoOfRir9UGYCIUO
         Cfs9atXUdutOINlFHt9FdWXVi257TcU+8lmGHszBDSifC99lZmXSPPEZLJ/tGQzRJNTR
         r4l6r9tGSuXLwjk4rlNQqtzhU/F/W42AbAcs0VpV692AIdj+3uqeqVgb+mD9kPQxDKWq
         l9dS8/WbZttp3qGCI+T46HqrL+oYN4KPXJz3CtchIWZj4fgeGJicg264dVHxOTWLFsCv
         0qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480526; x=1792085326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLnG4NV+OCfW0E5/z7fquJoe8Y23E5YJCg2MvT6naiQ=;
        b=ZT8PVxfjTsmnAPCOVF5rO6dxOAbBbkm+cpxHaEtDHExfwRhvc8p0TKACIoqlDN8ISC
         McszDwHMSgQKOgIK6WfogNNyYLleuV26tB/LE0VPvztJKxHNFy3I+bf61GVO+H2Vwxbz
         HIVm3wjVtRyCsLdafQ4eLlU/stiU1N5o8v0NNsGc177+4YvyVMvMqifTPaD5oPA9tLRH
         Ay2MdJFo/FdRaJrV734NAZom0QJ+/tcWsZijIYrwi1Q+3mx8TZPtZx4E3XLDqKmoQSP6
         F15vK2Or8z4bPVlJX9xz1pGvacO/NIsg7irI7pj8UA4qXX1hb9uZrQJNttVu8/CT/esq
         twIw==
X-Forwarded-Encrypted: i=1; AKwUvBzydeFDDHESnYSVt/0BRopYE3/3E+kSwwLW5lXghK08WWHs+zr6vKKVOOM3KutM5POp7l0=@vger.kernel.org
X-Gm-Message-State: AFuF++kyETARdWi4yU9vK22HbFhSmWj+r17hgMMQLuG1nWwxO5fd3Hdw
	ugWNyvwivYB6Mvv2Yh9WTohc4NxDGPmBjHm0oCnScj4I7zkAiZYaVP0u+mDv8qbUNZv1jRCQKEO
	13C7wKfQRTf4FBQ==
X-Received: from pgaa8-n1.prod.google.com ([2002:a05:6a02:6488:10b0:cc7:b6ea:3094])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e8b:b0:3e0:b1b2:2ae9 with SMTP id adf61e73a8af0-3e1340999cfmr5753819637.47.1791480526005;
 Thu, 08 Oct 2026 10:28:46 -0700 (PDT)
Date: Thu,  8 Oct 2026 10:28:40 -0700
In-Reply-To: <20260310060022.15120-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008172843.680198-1-jmattson@google.com>
Subject: Re: [PATCH v3 2/9] x86/cpufeatures: Add CPUID feature bit for VIBS in
 SVM/SEV guests
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:14AM +0000, Manali Shukla wrote:
> From: Santosh Shukla <santosh.shukla@amd.com>
>
> The virtualized IBS (VIBS) feature allows the guest to collect IBS
> samples without exiting the guest.
>
> Presence of the VIBS feature is indicated via CPUID function
> 0x8000000A_EDX[26].
>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
