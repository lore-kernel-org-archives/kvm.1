Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55B239085
	for <kvm@vger.kernel.org>; Fri, 16 May 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421229; cv=none; b=aIHRVHvmvcE67M35TNFP2sdsf+Ljj/0UVf8wFNN+FfVAC7E5aRdAUqMCDuKdROoI1HV5oIdW7y5y6281loItkRAjkQWNTZR+jWvXYlUfHPE25AERs/4k3+P4bCIwi9NimsD/msvLM9jEkSUpCQVu53uCF+Mtq2xMS5PLRRlF79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421229; c=relaxed/simple;
	bh=XQzr/P8LSzc1fGmKf5TzJFNWuKpMYhmvBe/dgZKthmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWXDdsEN7KmW13yM8IYWU/0OegvI4Q2ekasMW3zhuUGS4NnS+a9SmNpaB7vI6Qu9dHaXD9/EyOkLnh7mbCrT+yRBtEOgo67TQc1OupgP0ZtgJTIs17FepwTCZWP916r1HFKc5ujVCnnr0B+K4w50pbpeXOy68bHPFOw3u55uRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmoktlVs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmoktlVs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22fd4e7ea48so22487985ad.3
        for <kvm@vger.kernel.org>; Fri, 16 May 2025 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747421226; x=1748026026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmq5yOzKEYHGMlWUHQrdCglzBtv7bOn/Y4UXiljdeIs=;
        b=xmoktlVs5hMz9PDKC8NIaTrKDZRwzdbCk4gj1oH3op/wJ9crQFte+iJl8WtOSDuW13
         j+55aZFs4lVQU9VNhg7Puk38H7HQzqFnYeE/flXuxOqrx44kNm5juM/5NumeacWOgIUn
         h5w8RJVRgSd1/7WYX2PNff7ySpEYsZLkqPMIO0LVRl1yQVaOkQKHX3Ttq7vE0mKBSER7
         YQ/blYHQtfhLUMod6mfVDb+/Ls8SdB2zAlLvc2HjnyiNMtZcBCRmJe5VGxotqkF+JLGV
         RYRB55wwxrqy7yCl+RzR9g84g0pObt5boQBp8jfig4xSZqf/PHZCuKpc0UaIIJjp33kY
         K90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421226; x=1748026026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmq5yOzKEYHGMlWUHQrdCglzBtv7bOn/Y4UXiljdeIs=;
        b=LFvmLE6Ex/h3YfTY4+TKsu5jux0m1aJPCDpM1Gri2yuITT2pKuZk9HCoFx1ZJqjZ8l
         qIsuS3Dik/EtX+y3IMj1XgdQWpAxWK+1vfqpHH+AT/fv3mr3kLQKoeaKlmC8dglr/ChT
         KZjhOdm29Dg4v1nMxyVfVmy383Vo0zbGtzLbwjXq3Cldl/AeFJQsnSLmJjqWQ0TvC79N
         U+J9kps6J4uIKO3sUJRe1deViTETGb/ohfWAwe9cQ0WyVs0tBLa6kAhzaDC7yeKJuEjn
         Kg/JbaW1VEyo0SD6/cOh7mKAUD3/jB/UOnZ7aXrMAGUBXT+9kKot8R4H2TCwR39eipGB
         Ikyw==
X-Gm-Message-State: AOJu0YxRCmphxxUu8gIXlVQv0Go1EKlugl+ycUpYrVui26LmBX+/sL96
	BF7QH5OKEU9/M6trAQ1zmI1tSEHF3c7O2f/9eD64Ej2y/fHIlpm3dy9gk1s3T2t+gHx41oqqCzR
	8WveYlg==
X-Google-Smtp-Source: AGHT+IEoABAHTdXlaeskcgYJu03drz+RNn79bIJemm7dWQc6taI6oQUGfiZBOrFd1GdJMi2Hp8JwioagtxQ=
X-Received: from pllb5.prod.google.com ([2002:a17:902:e945:b0:231:e3f0:e373])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d2:b0:231:faf5:c1d0
 with SMTP id d9443c01a7336-231faf5c3ecmr19177195ad.24.1747421226086; Fri, 16
 May 2025 11:47:06 -0700 (PDT)
Date: Fri, 16 May 2025 11:47:04 -0700
In-Reply-To: <20250508184649.2576210-8-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508184649.2576210-1-jthoughton@google.com> <20250508184649.2576210-8-jthoughton@google.com>
Message-ID: <aCeIKDbwVIlBLtGz@google.com>
Subject: Re: [PATCH v4 7/7] KVM: selftests: access_tracking_perf_test: Use
 MGLRU for access tracking
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 08, 2025, James Houghton wrote:
> @@ -372,7 +501,7 @@ static void help(char *name)
>  	printf(" -v: specify the number of vCPUs to run.\n");
>  	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
>  	       "     them into a separate region of memory for each vCPU.\n");
> -	printf(" -w: Control whether the test warns or fails if more than 10%\n"
> +	printf(" -w: Control whether the test warns or fails if more than 10%%\n"

This belongs in patch 2.  I'll fixup when applying.
