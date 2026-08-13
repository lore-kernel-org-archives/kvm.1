Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95203438A7
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646452; cv=pass; b=kozod4F/Xm6roMWe/UpTGh/Efax42DyjQBfbVs2r533hZz3kTt4Dfv8lqhJYhShqlEVNv3IExG1BSVo9hkY3jVaGblelFIOLTD+JZfKVmxHe/uy9Vzp2MOhNem18bFqvEYECyofPqyHMuE8w4tZXRpWlTsawtNQKwKITBcJx06U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646452; c=relaxed/simple;
	bh=SmuHUPl640dUfP/T8wiC16wCTI5Yqb/6dnMHylHeXNU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo8dJsZNV3L1t5L7Te5uPh24XGZ+SP2NHBm3+JU1OLTqIvHqcYaNeOo8J7fdPdvNdOdL3HFxr/FS35JhqIVCtn+Ju43XVRKeh6M48ibiOZzmsY8ER5vQ+0tehLDtxldAk4ydDyCxbAMXYR6uoGUzeeXORsHNtR01LFQoSDz6LuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtH/gMxx; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtH/gMxx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so177385a91.3
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786646450; cv=none;
        d=google.com; s=arc-20260327;
        b=Qc+bSzJK9WGzYng9Et35Dwq+eeqRBjWDndSxO+9i7a2Y21XLoJ7PEUakDZlS7JFE3I
         rPnC72pWQ3Ut8l9lgUbmQq5h3GIYemt28iaK7/3dL6QTD6Aoy9/TCY5ukwzm6uNyJ1HR
         SLpj++kITu45yF8BIlIzkRddQ8vo3i2Bly5cD+S8NGCEg8QPLjNFABDOtqV5ZMm19y+J
         pnSuqr1LpRomC+xeQf9acysTKmZzCo4L3OUUb3u8ASgn84DhPfG0t24dwEZ3yXvHJTub
         b133U5c/1DsD+HCSRB/CL1zOGEuD9MDQo8Vyw9or0pTgCc4F7Km1kUHj7h4yYnK8ACBo
         FQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FfCarHoh7qSi7mQScz0h/iOmFe8yy6xC72Pgonixm98=;
        fh=r5IjS3k1X7xzBj5v5J1ODuaNVCFBq313gBExdxWjiAk=;
        b=lKB7d6gET5Jm+nTNtFQpVyuisgULcymJP8Bx4tNtHwoG5zW3KOmT77R0m4fr2zLH2r
         6AdjtUTEGXEHUrwI6c6W0Vl3dsDpbmlB/cgXTjUVnWnGvNFuBDb0SDNvDDVlrk0cZQD0
         qElUc0xcBsRktYUhKBUi+S+X8rKljtkzruPgfvKooONfIwJABaBLxQBUvjYqKdZ5ezUS
         v5+zCOByZ5sxW6BYE7n2v0/6RWcaYWwybYH2l9KDaoo39WXCyBdcc92Gpm5hIB1CuyLA
         sqvQFEN18DstnTfTb5RG46XX1NJcSd93nSI016H8MEOYT5tns6A4syspQzGBqcogLyxX
         vceA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786646450; x=1787251250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FfCarHoh7qSi7mQScz0h/iOmFe8yy6xC72Pgonixm98=;
        b=rtH/gMxxvOe2cU1ddqq4AyofAT0g/9O7Nm6G9AFpyc+uZP0jsMvlRGGCAE5IBoNkZB
         0diVPyDQ1x3p14dcs1583lrDRK3j45lg1uw0+J0o8+bRphMPncXVJsOAN17QZEReqvBY
         K8eTzDaGtAHTc6Ps1tEvo41etvQTw1sTDz0fh3MmpoaGm9jPcg7HwjwoYMCEaLtwKga+
         zOfQ+5xL3qxCtUD63k7wyp7KM2uHTzjBxs+tzuphLoCYJZTogggHTYc13cMz7ERNxsPJ
         Q1MakAvGm8oZmjKTMQU2lsN1VuF0xggalJl4t6iSQxs9pMGoeUoJr4OApLPSS5tGyxX4
         /SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646450; x=1787251250;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FfCarHoh7qSi7mQScz0h/iOmFe8yy6xC72Pgonixm98=;
        b=i2blPg7ET0RuHsl7bKayDns/h8Qx1Rvu0P1+pnfahuX2Nr6lPiGRoe1xtCxNESQxuN
         KVKIiyjuFZVWsDObToP+XkQyGDVxPzGncK1rfgT6iOrJCRW2WDRTulD9pETQUxCzArAk
         QCwUruS1G/b+FedXQrLR4kLBwGhv6cO1LX1NSesEdX9m8UoEqvjnliPG+qpSKGPWdBEf
         uUWzdJz0Rz7+++MMyJN/nI1II9FTTiUEs50zz9TeWDhd49Q532Exo43+z9fAWcMEX/mF
         /xx0ymay1ebnDYhGsjAdzUJj7LsN7tnb3lNCHYuo6YG75FVujfXyTtHPCMC7wfQPYS+/
         XVTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4vnqJ4fdFKO0Ghz08aJQTJedndI9DvTjwTJhIiGKSRbC7gY5B67quA0xF0y2Mumkmkjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkiBx0FsTvk+y24ewfHW2oxUro0Bz3UraM1eqkN3HbQRIH8l9
	YntJKbaz/ndFpOwh3NRr/Mf3XOVHTz07xQ6Ey56Lf819hyRkTqs+mBrRE7ngQqzFeVv7kCNBHzL
	KQHVgtFfWcwTfYMmt8Y99NIrq1BGGZzGjHX/E5P3N
X-Gm-Gg: AR+sD11rQV5A60dm/fnTnHLr2Rm2vdbvnO3dmVCVb1XIStKkWXYVnV+11v449GHfx/e
	m2qHtmT+YVgyPXE03sDrnlmkgNsXK1jVI9YZ6/OmMHUhdIvmV0aoYkreETctI7RN2BNSV5vognO
	hwBu2/ypMZ8TaxzM3MApazrkVEvM8G4IPisiDoL3+M0TgIQZgH/hOF7DgjjPfy+poz3pGbmYzdr
	vMmIRYBBSFEdDC7SZ47HScruAE8R5bD5diFu6pYs4dgkciGu1cvLrpH6rQ3e3pWOry5rOlGwhv+
	E0XjSyhmTikHmib8EeBYGUD4WBCAsqJl7WKuOEVNSzGCXH+idOwc+L6QH7O6bZp+Imqq4njvkXJ
	13+bvTXOqHrqDztDklrvpRprIAiLmbdE=
X-Received: by 2002:a17:90b:1c03:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-3931e25f24fmr8532991a91.12.1786646449351; Thu, 13 Aug 2026
 11:40:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 11:40:48 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 11:40:48 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <cc44c9d7-a6cd-40a5-9f68-4822fb9c9d0c@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <ed483d25-d908-4248-b8c7-862dd35dc6d4@kernel.org> <annnrGR1noVuBkCc@google.com>
 <cc44c9d7-a6cd-40a5-9f68-4822fb9c9d0c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 11:40:48 -0700
X-Gm-Features: AUfX_mwbi2KKm_8JKoJYp71B4rnhRB-DpUSQbtCK9ZlqdFzmBXno1Ngt_qJ6KFA
Message-ID: <CAEvNRgFd-6-QxR7w8SxPRa0UU+AAF7pDupLP8cPbQ9y3m=2QVw@mail.gmail.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 8/10/2026 11:01 PM, Sean Christopherson wrote:
>>> As mentioned in v9, the name is confusing.
>>>
>>> 	kvm_gmem_mem_is_private
>>>
>>> ?
>> Ya, +1 to kvm_gmem_mem_is_private.
>
> So kvm_gmem_mem_is_private() calls kvm_gmem_is_private_mem()
> internallly. Ummmm.

How about

  kvm_gmem_mem_is_private(kvm, gfn)
  __gmem_mem_is_private(inode, index)  <== this is a static function
                                           anyway, though it calls
                                           kvm_gmem_get_attributes(inode, entry)

or

  kvm_gmem_gfn_is_private(kvm, gfn)
  kvm_gmem_is_private_mem(inode, index)

  (rename the vm stuff with the suffix gfn_is_private())

or (current, it is actually weird)

  kvm_gmem_mem_is_private(kvm, gfn)
  kvm_gmem_is_private_mem(inode, index)

or

  kvm_gmem_mem_is_private(kvm, gfn)
  kvm_gmem_index_is_private(inode, index)
