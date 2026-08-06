Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F53A7F68
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979235; cv=none; b=kkCg5GJjQdufBdQ85NUE3L8Zqz9jIhMs/zuncSi+9Ay885GF134LAbuuLBsFQu9fNc7QuyNB5PqjyWDawENLFVG0cZbW/Iks6U5ZA8HRcqc2+JTNWc3iYKIvRMuxnDPjlgqmVwss7qvZGRwo8EL4QUjJ5JbztupQkg6JTc3ZF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979235; c=relaxed/simple;
	bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZFbM122Tz2NpS3xDuBST9sNIFtDnhFBBi4u5/6BLl2DjjI1+X7q76K4Hqsef78mGRkyuLG0XuDDzmmULHKBWzBw8dCB0QAN8SNwClk+lbaFPNVfiHdakXhPiNwqoBpTXEbFFfxkBYPkziXoNxXvvP9+XZ03BPL89UKgOySA/zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMoYatxz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMoYatxz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so1440674b3a.2
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979234; x=1786584034; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=UMoYatxznLxJTTpbfLaRKY/sIiurNHM6GvSWSrhqZGRPy2upqpvtxnzXpok3ILMy0t
         HVbPQqUqTq6aayqIq65BqE/9kreTOJqhnjslebcWTvyXOCfnHrZsEPnpeulZSIg5wMLO
         vSPTm5MQqF1I39Qx8xUg04JuhwsDtIfLDAG/nYRvsyO4GtgWerHV/A6RbBjKF6OgBTlI
         Rc0Srn1lBve+6WMIdoxB+O8BYDi0g5Bcpmk0L9mPfqPHqnszm7zGvR892DS2r6lT2WC4
         CZyfTWnPjbGGfR6dEib04yid2kxBmdnTthTnQTb63sITNanK+QcKge2RCQaJway79+8u
         Sv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979234; x=1786584034;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=jlboSrRHGpvHdWGC8dNzR0rawn9Tmr8++LTprpfpSbQhyGu+kOVmr3kc2sNlyRH6Re
         lMrkWTd7sv7Yjnap4f3ztwO3NWLCEqo1F1QCVOXr1XVA8/ePGwD0wamSrzYZek26m3qe
         gyjyHLCO+ZW+7nnxHHNiKJVDTp0Ngu9oI744syEshUg0zk6wTKCvFePsKVzmifNpB5H9
         oJ99/ZJfVJB9H4DyLEQ3VrIjqh2oS7GdapaG+HgRHq4T/k7srw3LLhjrgUbUh31Pmz7a
         ty8aU7yLbk8b6k7UFjeQoGnLMCl78Qvsyg27Zs9LtOx/DhOM/Q1Pk5Qr1lcZK1nqn23t
         pmdw==
X-Forwarded-Encrypted: i=1; AHgh+RqZfs4CO29twaNXhA+6xetCytxMX/7mPtIc7/U+xArILIxv9faLF2giB5Zb+gnRlz4n8oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg37LIbGSCn1QzfL2SiBffNJll7E+kz2qnaMrettug21tTJNQB
	1Hk9yrC8l/riXp17UEWP6syJu69aoXbU3iaB2I5RoGeh07B/Wctz7tmU
X-Gm-Gg: AR+sD12VKGqvxWT5uUUN5WMfd3d3QH2HMvL8nCy5BL+1ml+bkfvFXt4Cmnj+M2R+rKj
	WIOFupu2h6uhlvryNHRehCyjHc0o4jXXQ240NkAW83Xt9+m1YAN2EsxMXuM4tfxcT80kvyMSdxa
	NGrSvDwCqTavWDYwW/y+zTx7j51IYWoFrcNFUgk9JHe6QYq/v5uD6CL/Jz/bVcr6lK6QExLgeMz
	s44hEkC9dkMYZ8iwXSYD+jq8cOez8oytEhMUs2N7gaBD7jhAatGpHOU83pS1V10k/2FWwnSoA4W
	uLkY+ubBJplOUzEhlb+ci0xCf38v18KdBzMSWWDbGd1H+PISQil6ZdE6W/QVO0gk0YjSHDnjYH8
	WQxC85EI7IS/XjbzoGjoExPgLsD1E37fWvqLPNyU/FTekrExnYODLPYbKoSCwKbiDrZK5A0MdtR
	kmvfo6wRyOk66RlULs7iEtNBRXCIwyZG+hlhefYA0FP27vlyWF4pz9P/qdzXk=
X-Received: by 2002:a05:6a20:4307:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3cb85dee55emr11951526637.1.1785979233570;
        Wed, 05 Aug 2026 18:20:33 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm23448029eec.0.2026.08.05.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:20:32 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()
In-Reply-To: <20260804112011.59416-4-thorsten.blum@linux.dev>
Date: Thu, 06 Aug 2026 06:50:11 +0530
Message-ID: <qzkckptg.ritesh.list@gmail.com>
References: <20260804112011.59416-3-thorsten.blum@linux.dev> <20260804112011.59416-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Replace min_t() with the simpler min() macro since the values are
> unsigned and compatible.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
