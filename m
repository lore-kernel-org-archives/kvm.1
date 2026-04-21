Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56B3DD52B
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802232; cv=none; b=fHQv8OhaWM5GQ/HAnVfWu2vB9w49MMqCxEnePzxQoahXa+o6ODcO0AsgwXF2EtsLe7KziavTrlKC/q/D2IzYEWKE5PgF/gefR+LU5Fk5fL4PKvgLWr5ZychnBiJUONKFIN7P17EJ27OYBgzV12Sl52hKzUC/9hSZBTV0cDVuqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802232; c=relaxed/simple;
	bh=jJhdMmDpEI4YTob6x7tbe+0j9Jno+gpDkiP83eoohPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pupZgkU0iMqEfZDP6VEuYMq2LfRjCx8rm70SElGyAimPxGBjkXXSlXUX6lOfj6rz26Bxxb0YFP1z0aF3HK36iL2LJjVGddsy4tlp3sk1UrojoW4kJrdruUBpju22HAYwKBbhiWNRHLCwmjSjzwI9YK4xajEPF6zr04EWr4GdZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMrAJCNO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMrAJCNO"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a10d130b37so4585453e87.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776802228; x=1777407028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/5oU7amdu0z7nvjPYd6YcR/1tXxonAi/NB6llIwWbI=;
        b=AMrAJCNOiEqPKluuJdYQxSSApHcmlo7sWVvjotUXs7dmSMvOopSUbwXUSBMYsEiIqY
         xSYCckIFdfMgS9RfhgmVgTDrem6taeTNs7xrjX9jZpO6oHOfOCgzuW3jBZsd/djGXMRr
         6LTK0zbKnzU/4wlhkv7dlJr0rl4kvk4HjeRihC6D0Rljd0DeKFZw5aoTzTBptIYfKnNh
         Jc4mMmmeFVznzycdPmVxMKZFwKmlPJm70dTY9b9B2286WsUB1XMQk39PrQ6Fpwuj7f2q
         uojIeqVBEbg6bljNQw5vkNgi8vQwJXRPenjEgaw5eWgidP6eTfrADhmU1LKlNKlVwW6v
         bA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802228; x=1777407028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/5oU7amdu0z7nvjPYd6YcR/1tXxonAi/NB6llIwWbI=;
        b=mPITMEJn1BwKJZvsRVNW95ae1WZ1s2bGCOOoDeQKIHFOFf3sue5C8hbw+sOoagBHIJ
         MXmAm7I0CdDueJvOb816f+StGXSAwVRl9FOJt+L1J4SRHYeX3rHRNpx9Lhq6SzdG55n2
         43KZMBY9OYGQ7XhrQ3JEv2P5aUiwgaS3YZ/ammfvWo58xx6VxvkNUIYWmSHrd9O5x5ur
         jqwolVUYXA1H415xopDcujzPsegevlSClPZOMM44ybaWUBZ2zd4m2FHHPjz9zui6t5pE
         p+PPUqzA8Q7iVubnF/uuhbxcFXccgCX8erTUS+w9zgxJ5WDcBC+/Yy8UI/QDwea5zTOU
         neCw==
X-Gm-Message-State: AOJu0Yxmi6uK6KhlDqDoJB9SKXjgb15VW0g0PWtrKn2N1Nxm5rnVoXmt
	9JdvZvZH/N3OmDTktsoIrt3i/Y3wcVI7Zfcrxl5iZ6OD4AJxgjwGhG7q
X-Gm-Gg: AeBDievt90EVDjdqqLuwBYI748lWfO5j1ufCLgpcVRhKIubACGJyuzJiSXsCPNeuhLv
	aoqbkYlREBJSnYc4ClXmvliRrOsSFty9v7lk0r3VkNDUqU+1vZR8hTiB+iq463cATcT4XDF9x7T
	ViPba8raQOYJTvZd2glBCbP0G/FrB+DO4ztogufW0/zn++snFnsga6v8MjI29Su3yS/Kq0flqZN
	0KNbnuTVbLNGb67bKRUt7zkB1ucdwtCsRfjONWZbBYnbDJNh62U9GB3HbHkaVdEm0SFtOVRnImQ
	kdRQl3O3mpQneb9XdIYLADpHzAbSjyWw94kVat/pWAIONxgn11V2UY4TOM9311ALigFy9BT1Jn1
	sQBEB4qRCvvZUKOBX7hiaOSwvmcCrSvqrpfU1ROgWY3qf/dle40JFflRfQxmsCMqj2FrU7W1D9c
	EWsiRSdZ2Pj19tKLxZ5hbf5S8YYNT1nw==
X-Received: by 2002:a05:6512:3e20:b0:5a2:c962:59f1 with SMTP id 2adb3069b0e04-5a4172a3042mr5526839e87.16.1776802227777;
        Tue, 21 Apr 2026 13:10:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ebe3dsm3858063e87.74.2026.04.21.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:10:26 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:10:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
	shuah@kernel.org, vkuznets@redhat.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: hyperv_tlb_flush: replace NOP loop with
 udelay()
Message-ID: <aefZrtpivxh0eK_0@stanley.mountain>
References: <20260421172953.191345-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421172953.191345-1-piotr.zarycki@gmail.com>

On Tue, Apr 21, 2026 at 07:29:53PM +0200, Piotr Zarycki wrote:
> Replace the open-coded NOP loop with udelay() which was added to KVM
> selftests in commit 6b878cbb87bf ("KVM: selftests: Add guest udelay()
> utility for x86"). The NOP loop is CPU speed dependent while udelay()
> provides a deterministic delay regardless of host CPU frequency.
> 
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> ---

How did you test this?

regards,
dan carpenter

