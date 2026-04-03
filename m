Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F23C9431
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229309; cv=none; b=CHnLguwYt4YNNk2IFUq3Mba2ZPLZ1ZEVEtVDR0kKBk/x6lLLbECmzenh9+EKHdfB/5EHTalY01k66XEqQTXJu9xGJbIlOca1JPFgXDoQyInn5+KJWTQxGCrFeHGnnyzy9IFLk+AY6Y88UzxCrta79uMDzKxogiMI1wh9DSN4t8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229309; c=relaxed/simple;
	bh=pYMB7WgmY26JL1+IglrWtHd9vnJJvJPoKh45QUe7eKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rubP5ykfg5Zhnsyn2ssEvZpNmyUjLaAy5zPkYnRYFJ0eAPcejGWX9d+0Ven566Lt4v8uBv8NQvnS3L7KLFOWRncHmqTgIRdORZWVThtb9YCe2JqdnA/z4MwXhRomOPXGLkCdiOfwLOeh77Vb3JMolAqLra9jKbo2fut6XBqFyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crxl1gzC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crxl1gzC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a6906e35fso2849005b3a.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229306; x=1775834106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rg0ah9djrHASGQ91zDwrFr21BVQMv95UmXWoLJnBRlg=;
        b=crxl1gzCP9TuzBtGFr33J5nLbARBxj9JCEMYBS9fp6f2kj4yN8wX+XKRwml71SqzVG
         /vFsSR/EILZ297WINkGC1qJo9WtqRmQHU9JHUPmP7r1p7Pf++OWqgHRdcxqQMLEzfwCA
         mq8gKoQ4EsDfDrkjXsiGz6EpAFPCd+1578J1kRB6N/ReWHkIwpZibskQzABeaBG0TAeJ
         4j37uQTkbkMp3IPmwOxL5LLg6s3Qw67Hew5mBaMrzCLnDaSEgJDefnM+GwFUs3fu/4yk
         kb1ENY5R7HAXPUkRKGbl3tK+ddBcsKD/ufKHnH+9/ch0+OLajMZgnmm2os9QVNTDVP/6
         Mkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229306; x=1775834106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg0ah9djrHASGQ91zDwrFr21BVQMv95UmXWoLJnBRlg=;
        b=SIxm/sRSKzVJbb7z4y0pK3GRx832rgUISj60AK4dEsyNWN5FAwgTCCq6nXhYCMzY3H
         3/abgXQlSFHfXV7Hnzi9ap0W3OTeZ6vpQHrHKI1BY7y5XWkZ6BPVPkYhBU3qmxsUwmrs
         KsI3AfR1Gh0/cp5rbVC5nGGcOM8Qt9anBY2ed3u9g9V5RMZYt+ADVRCbM8kngSfPjEu4
         vpW8IEBqJjwsGxm5avlpABiHC/zTgfMpnXxeaYsHW4Hd8FY30shn6FbRhaRevOQX7b72
         12ktie5enpNXcYh5CcHk9rgjKylxqPirXPtF1czWHoYAj3RUDQYcLsfWTI7bfQFmdOqQ
         /zMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIXPQ0UQyWGpRNdb5ktH4Bcck9QWZonRGe9e7rrzWQjABjBQwpDRZ9nU9xcwkffSm3wek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVwfr140t6h+xN27Fm0jBeZxFI4tfOjkijjgJppdHa0LhNVIG
	DAv88mqAE7gGEtKCRbkmEfPrvBm4xT/Zv/Of+DWyqMtzvVUTspp92QcDc/p/GZ1WUeEdMzt7v8u
	wa4gk2w==
X-Received: from pfbfb4.prod.google.com ([2002:a05:6a00:2d84:b0:82c:5b7c:f4ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d04:b0:82c:eb69:1936
 with SMTP id d2e1a72fcca58-82d00322a0fmr6051814b3a.19.1775229305797; Fri, 03
 Apr 2026 08:15:05 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:14:00 -0700
In-Reply-To: <20260306231253.2177246-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306231253.2177246-1-xin@zytor.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522879128.293765.7807311601476583191.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: VMX: Remove unnecessary parentheses
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
Cc: pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Mar 2026 15:12:53 -0800, Xin Li (Intel) wrote:
> Drop redundant parentheses; the & operator has higher precedence than the
> return statement's implicit evaluation, making the grouping redundant.

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Remove unnecessary parentheses
      https://github.com/kvm-x86/linux/commit/577da677aa7c

--
https://github.com/kvm-x86/linux/tree/next
