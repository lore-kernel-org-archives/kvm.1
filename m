Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484088;
	b=40xQc4P7xl923Mc0++al0bPGNVm2oPEJ4k8F1PARrx1rTKYyFGFAGPcbC9CyUZBioHtl
	 Pmk+FuxsbV0FAyQhqMEZDuYYPJZx+P9/vqko9jvPSCGJVyj9djQz4GDMFRPT31PwF8hbe
	 8OPttDVMAbbNklUyCfD8D7Y813rkOi2750OlxkpnCAyAscl//CTe/F+UGfmfq8R4Ukivo
	 LkViP7lnTzFIIP3KqtR/iQ79iYaCfMqpK9ZIzbcaBQkyirkmTuRMfXfnv5z6iUKJEppks
	 9KY9Kn/ta81Y8RxmSoIdPCfKD/KF7dMlia+Ut6UK2uTF/0OeTPgcMa/uTzGME141fmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484088;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DUppi7wmCC07SfVICm9l2NXXwmr7ZReAVb6VJt0FJrU=;
	b=gI/U2beGBPhUzFKpTTBWyODJo2FlLyj28YfKnD4v9liAm3LsR5zgTnKcBeUsWXogwGAW
	 o+/2iLJTFbxnGXIJysvaZBVUlbtAuhQAokkEqWALdQD51gPuiblKOS/kn9M8MK23UrZkI
	 FTaRGgZ6bMTPyY+7SzC3QnZBfI3B6VvHq1o5HFdba2V0Cq8tyNRKWsUAGoB7ZnwYYaoag
	 YkdJdGmVZ4vGoAthpODfacLwiI94KHmZJOCD9zQoEEdzxOi0wTpw+gDj/za+Eq34+mbd8
	 axKuvyQYXxsu/bQz3sVK60D9lsxnYqmsmj2MyZo5hj1hDaxLbKCDwLD5ghxE+tN4VEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=pereq.eu;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C4606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 11:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a215e64962so45709995e9.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 03:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484086; x=1795088886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUppi7wmCC07SfVICm9l2NXXwmr7ZReAVb6VJt0FJrU=;
        b=Q5KztjES6kvqhVfis6d6Hv+UWqib2B0SFyCeLLrwGlXRV9IHdIxpEDvaOto6IQe4GG
         wf0Jp9Kyr5hTJTPHsi93zGtacHaN1oiYjUt84q4KemUaWlXZcNCy25oMI3qc9C8VFLMQ
         iZXWDwOUTk/Ec0P9wT/TtBxPqvNbDG7r6zXHIbjv/BF77aFuQEM2mJqCZcnVg+HUgJIP
         X/Z+Hi+KiOtfB9PmmqvYic3Ss/zFbb3AwU/OL06hHKvzWtvsEjbLIJCkWEyWcx3b5EZg
         8duquRZR2mA419bmqCIEdVXOJ6Dw4iqyP3jDCZnat12RPjGZkKnn215EX8ZFv8dF7hPS
         cqMA==
X-Forwarded-Encrypted: i=1; AL+hErGwngm0f0zjidVwyK3RooxU1Okbrs0Fovp1dvTo4TNSWBOQbA+7BzAGwRYl5Z7TjNJF6c4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9c+5wV+gULqSKxbp0S9fE8BrNt0KK+05d8PQEe6XgCFvO7GNo2
	DEbhwggwVLPj/MYuqPmwwSd4zq6lXqhk08PdV29IZAkTcn+lWxLstvb+
X-Gm-Gg: AYBFou048QwJQ+B7Poa0MMwTWJ+mzx0HKZ6rOoY6G6PJQEptP/YvazkWV3xqLOX6NSD
	jhbqN9uymg4nVqVGePcF3TM5Ql3KphUzJR4EOOemCRLyOQa4o5Se9XpwQEBi09OOY7Sd1xQ54Vz
	07G7qk4JkXICZRGnyZIr4ZnrjqQ/eZCHYS60Ug+m/2CiNd6c5ylP2RgBKDrBx8xMd+BZ+W/f5Ad
	Frwblm0Stq+NidgBFAe39zvi81lRxG8gdS7NGahqtX21vRpyOYqXu3e/JjonOuiCDUI6lWoM/GQ
	3vwS9UE4M2KrpHTsSN52xp+CJC36ESN3lFWZoLudwbVsBOjz1Qu8pTNpVXHxhS5owwWhOHFi4N3
	D4goYNUHBKtv/U7DU9xJWgstmmXwTGyz9eeR4TEMs4pVCqecuHo5KExOKsgR6KF0cgjYshFgBQt
	Z+xyChXWRndYNKw4NOrn3M0ZBiTwtRO95wv7qXo2aV/vueV1SeHWTLaHx0yjveJD3oP99io3cXC
	Voyb1iskChxXN2CMqEdNvGIuVhHOFHpdz573YgilOXdTYxhYwX5oS3xDJDg/OYJlt9oNyqSStlW
	GoKhsBO3huW19N/JgIsc104FR1pVRKCkV2SGh1PYDGYByc2RbczEF02wcgHUoRxHgmug3iYA+LE
	u12L+0gtE2AriGUOPbyX3wR7Aj2gb8F0hev9OusR1XfqSSA3TpNzou0yG5Txb
X-Received: by 2002:a05:600c:a4d:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4ba0938e39emr104253715e9.29.1794484086102;
        Thu, 12 Nov 2026 03:48:06 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0950394fsm97148635e9.2.2026.11.12.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:48:05 -0800 (PST)
Date: Thu, 12 Nov 2026 14:48:02 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Priyanka Mani <priyankamani2100@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: nSVM: Check full nested state size before writing
 to user buffer
Message-ID: <avWnci8x0fn_4ck-@stanley.mountain>
References: <57324d544da1e92cf3b30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57324d544da1e92cf3b30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com>

On Thu, Nov 12, 2026 at 06:41:43AM +0000, Priyanka Mani wrote:
> svm_get_nested_state() compares the userspace-provided buffer size against
> kvm_state.size before adding KVM_STATE_NESTED_SVM_VMCB_SIZE for a vCPU that
> is in guest mode.  When L2 is active and userspace passes a size that is
> large enough for the header but too small for the vmcb12 payload, KVM thus
> skips the early exit, copies out the header, clears and fills the full 4KiB
> vmcb12 area past the end of the buffer described by userspace, and only
> then does the caller notice that the returned size is larger than the
> provided one and fail with -E2BIG.
> 
> As a result, KVM writes up to 4KiB beyond the buffer userspace said it
> has, and if that memory isn't mapped, the ioctl fails with -EFAULT instead
> of the documented -E2BIG without reporting the required size.
> 
> Compute the full size before the check, as vmx_get_nested_state() does, so
> that a too-small buffer is rejected without writing anything to it.

I would prefer to instead move the if (user_data_size < kvm_state.size)
check until right before the copy_to_user().  It's more future proof
that way.

regards,
dan carpenter

