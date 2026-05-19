Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A55223DC6
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151443; cv=none; b=XgEv87DSFE+HsX6BFVVEKc8zWsaENDIM5x/C2EJIIP77Um+69Xj5mHFmVFvdRgBZ94t3l84ymn1tFXYklsmdiuymt5oYFvw3mABj5wpd9XKZaJyb4m6hMZFjsAs96VJvsmFG4gMW5ODS0wLGVTAmvGXipEuUCk1fHYqEBzQp1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151443; c=relaxed/simple;
	bh=M42PsrU6o0PGT+WkZ+DA322vfkPXIYHrF/QxepmRbeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgJAu38eBjmCUVAjx5zJ1N8ujdZq12yNAsWsHAIu+eqIQ+l+wTLGYRCMpzwoN+DbfMLpMRU/jx6vitFCp/szuqIsYdqs9qmQn0K0Fmkkjluz5w+gJRFPPOvmvSWXWyez5KBjTqJxRR3NCyAHPzlRVP3jta+FHQabGmq6cWDMxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngilIGLr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngilIGLr"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7378ad0so31976705ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151442; x=1779756242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOzzVcweW7m8AIsSnrKDu5TusjRT2YD7Xt7znQYZE2c=;
        b=ngilIGLra4hDsdzpv7jo4MYdCx2pcZtvomqxin53oIW0EF8S0oWj+q6504ADcCjVF5
         DQ0J2ugMBBqF59AzCId2C+0Hu53i8uJYMXLl1MHhZ0Zqs0q1VmtDJHwyFWQ7qMpxyE56
         uE784y5xOoaX4D2JkYIgLS0605AZlC9WFH95ljbAXsY+AJFRHPneElUBPK2VBw1jMfVC
         DFENxkmJVVsAjhnD0NUyWKNz6or5eRyqDb7FbGYrMYi7ApHE8wMzCOht3DbHEzDYLYhL
         PfxrGSkUXqHwsbN4x5TrXUxfqwnar0P01bdLx/kxnGzWLPrb0N4T3SOhtj75/ZqbUAU8
         BDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151442; x=1779756242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOzzVcweW7m8AIsSnrKDu5TusjRT2YD7Xt7znQYZE2c=;
        b=rh2W9qQzhOCAntWDwk/SU9pZillyir/fatc4hHl745/LwMBWPorjPL9MdXQ3sadTVM
         Hfv0Ke9kyElFtNbAqdJRhPtJLYQMR9fsN8uEw07b2rQhX1yzsdu1DgozizRzmJQLK1F4
         vWAZEHDrAvvp+eUUvKjKsFUpR33aLlmWqw6OBxNDploAHQLdXZddDT7GbrItEkrMotkl
         lqf2yN0FO2PXMqiBqZUmX/JDyGQdfsEz4LMk80I8wxrIDSEoXmAcPgW6w8hwsJ1Mo8k3
         DpY5Sts2oY7A+2pizx/9NSrDQRve5ZhtU/uWL+pmi+YhXkOmtsJJAfecpoiyZ4YWUVWB
         EzGw==
X-Gm-Message-State: AOJu0Yz5nmBgfAjPHOT/FeHfNvPYxVHr/B6Kvzq0DHhCt8VdEWik66Ck
	oTcmryvDAk/N169IdOmF5piZSa+HQEsKu14gu+TFK6BIb7x2WyTiB5Nj2O72CxgH/IBYnXOHRCv
	pCF/moQ==
X-Received: from plr17.prod.google.com ([2002:a17:903:4451:b0:2bd:d6b8:a012])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c403:b0:2bd:8dbd:17e6
 with SMTP id d9443c01a7336-2bd8dbd19c6mr166105615ad.35.1779151441749; Mon, 18
 May 2026 17:44:01 -0700 (PDT)
Date: Mon, 18 May 2026 17:41:02 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915111018.2230934.11606707706175599137.b4-ty@google.com>
Subject: Re: [PATCH v2 0/6] KVM: SEV: sev_dbg_crypt() fix and overhaul
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 01 May 2026 13:35:31 -0700, Sean Christopherson wrote:
> Disclaimer: I could have sworn I sent this last week, but obviously did not,
> and I can't remember _why_ I didn't send it.  So don't be too surprised if
> there's some glaring flaw or boneheaded mistake.
> 
> Ashutosh's fix for a heap OOB/UAF bug in the debug {de,en}crypt code, now
> with a selftest to detect the bug (and confirm the fix), and to validate the
> functionality.
> 
> [...]

Applied to kvm-x86 sev, to get as much exposure in -next as possible.

[1/6] KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path
      https://github.com/kvm-x86/linux/commit/78ee2d50185a
[2/6] KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls
      https://github.com/kvm-x86/linux/commit/6edd35e77a42
[3/6] KVM: SEV: Explicitly validate the dst buffer for debug operations
      https://github.com/kvm-x86/linux/commit/cb32e895546b
[4/6] KVM: SEV: Add helper function to pin/unpin a single page
      https://github.com/kvm-x86/linux/commit/99694add4af3
[5/6] KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
      https://github.com/kvm-x86/linux/commit/8d6297a3e73e
[6/6] KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers
      https://github.com/kvm-x86/linux/commit/4c735bf1bc22

--
https://github.com/kvm-x86/linux/tree/next
