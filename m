Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AE43F093
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246256; cv=none; b=ev6UUBv6Lx4s404Tsm9N0YuJ5vpOi8w0pQiC6EP/0MK6Pi9r+IyQ9zBUIkW8Misga1/LgOrpG6vLraPe0zoC5zfZvNwR54//MP1apdXWaMZJzxPv8yUQAWpW1Ct5BJ6UNNpMi5BztXvVWzEP/Iq1xOFFS2GyJSw3yo/MB/4644A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246256; c=relaxed/simple;
	bh=ozMcGOxt7KtDlMKiHx3sJsxpSbbDQTD4B/6p7zzan+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL3CkDJ/5klrvDk1sfLL91oF7IQfBJksA5k0YmyPE+SLeuJtctQrin1xZ0I28fgjxUyTFMcGD/NWDoQSjLG8twdmvxygcxT9TElN+v3uK2JmNOIdaaJbNF6DT6sZyb6wHfgcVEKqsV2soB0RtAOhx+7cgdjRpjfHLc1xKPMB3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glDwDTI2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glDwDTI2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4925a778491so2740805e9.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784246254; x=1784851054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF1WoIXi0Om6O5In6dkRDz7JXjPfofGyJ4Oa6lCowks=;
        b=glDwDTI2hC21EMdUig0dUrJOYh1kVbrYc1kicifvASBSk4EKh+m5BKsnVAZN8Npu9w
         54X4ws0emkDr8mqiFB54bHcbrwa4lJIieIoJJka8zOwgztpn2H1XxjsqyG1EGfY+BOVB
         cds8jSj2PsnJDT/KMcWVNkfpzOZnRTISXCUvh4TtfHytEY8BK73l3k80t9CaTO8M90BN
         zJgVMaPPBgYhdhfxtcN+zoY5hq91GcvsOTIfb5+2GzWyY9iSB1oTq7Nr4jWc1e/YiMvU
         mrfJU7a6TfE4ZxoP9AfMv/XD+dSrd4+eVBhutE/kzGvvv8lurszqM4FlajaauzrKf9O3
         Lb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784246254; x=1784851054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zF1WoIXi0Om6O5In6dkRDz7JXjPfofGyJ4Oa6lCowks=;
        b=seU+2Qw9/cRAFCKH12+iIlOzud6p4bgY/raFEnLHeOIN8Ra/Lxjve7UCslnbhm/whz
         vOIXReNMoQb+Df9P4hSijgKowJfKiiGDRwcYfp/3j4MF6m6btflk2kvk1g75n2DCkUcf
         5gee3sQ5g8BQGpVT64AmyDoUv4u3K0cOBgaL5gSCONtXmiko+WHuZydVqI6aFNpOL0w7
         8Xd0gPkju6QANS/LMpKmAwi4lGRj1jN42mm0W1VwNMjIFzEV2JTjmzXLak8bjdQcaNmy
         jMyHA8nvw7vvaRNHfyfruIk6/49rsHw8WcK2ug252ADmhOod6V87byKZiDVq2sWBDSEV
         Frpw==
X-Forwarded-Encrypted: i=1; AHgh+RoRCJhdib3VsqhYsZJSpZFKESOsX/huHnt0DkcbGa4cybx1EQViNOndUdPNnJY/7WdhXfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy602FJlbD4VUKLWGCG36zs4gub/k2a+XxRF6kICsqhzf9iLbEA
	jx0xXqccfPXfRvBAM7yE6uU55L0q4JBdvASd6iw99YZ1ZVHMAwl3q4jP
X-Gm-Gg: AfdE7clRye1le885iSIQ7jw48+jn+9BZBuaRbgaJMpSZbr930w/vx3b7qJopZCRJ2Bz
	si1lBM/Gtq+mLa7f/z9VvOhkyyJW8YBYHy8IiU0zXcU+/DWWAbJVKY6nGLlTC7q5DZKX0gPnc57
	i6LRHsdG504fxteiwulaybseAvPAnWmZegB1oCh+Rq7Tbp98A8Qsbmfzlu3NGO5M+CUzdMvqBZb
	YojsK7rp13f/JpNaIV1uVuH1BJR/HwRroCAIrU0lEs8QNxb0L1rUHFgXEccGN//XFuAtx6wEqea
	iV0W9zPHsDlGXZS/HecdVJnci4BN7yeDRr+kZXcUfUsVG7tlne26icL6pkWqKsLDbOQMQPBzAtV
	1NToyDLRADnVgjarFBU9wXz6JZzWf/dnVXSaLn1s6UZ5PCXSsSE16idqoBsHQmtF+3AHYEUHK1v
	giWiSkLMtvaZQQhT8JgXCi6ifPfrqzPrLJU49k
X-Received: by 2002:a05:600c:1f8c:b0:492:1e4d:d44b with SMTP id 5b1f17b1804b1-4954a5295b2mr525635e9.8.1784246253215;
        Thu, 16 Jul 2026 16:57:33 -0700 (PDT)
Received: from Kayra-MacBook-Pro ([2a00:1d34:9c3:b900:9e6:fee9:3abd:e258])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954966a033sm8306405e9.0.2026.07.16.16.57.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 16:57:32 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Add IDT limit check in __emulate_int_real()
Date: Fri, 17 Jul 2026 02:57:14 +0300
Message-ID: <20260716235714.28747-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608134642.25849-1-kayracizmeci@gmail.com>
References: <20260608134642.25849-1-kayracizmeci@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, just following on this patch. I wanted to also add some missing details. 

The reason that SrcImmByte is changed to SrcImmUByte is when the vectors are 
bigger than 127, become negative. And our calculations for the limit check does not 
work. So with this change this problem is solved. Also I accidentally sent out 
Linux 7.1-rc7 patch. Sorry for that and skipping the details at first place. 
