Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6147CC94
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351775; cv=none; b=ijkb8FhYiqOg04G/zd/BfqpKQt6S22hYNbMl8AQIZ8hp7c1YaWRSpR89m4pGZT8anJl7eECaN0AA3uZKhEyEl5CbW8V/Ytl1N5rgjr0pLyW2UQPLddQlrx19NtjiysECupg7HPo5bIpRXADRqOC1W/vwc/H2b+a7foL2lhw3IYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351775; c=relaxed/simple;
	bh=E8gqwSC0CUaQjM0HnP0GL4Pjjj7xxMwg4Q6dB9AQ21I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=umlyFjo91N3LHpMYavuvAir4D0vGhtsYz0vS9RVy2KWFV+kUYU0P/H/xmu0O7REXTs+ThcYoGLvy+0hfg3wwq1D2zXaY1/7b2Obke+NDBzLvdctKxgOVBBmlbG3dOEWUMRexJZR7KoGU8aE7ezO1eVqOSXaxPmPctU233pqL/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heoXaENZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heoXaENZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so349970566b.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351772; x=1788956572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHu/6wk7EVyBKthvUsQwwRxIg1oSagtsFckVCW45lBI=;
        b=heoXaENZfs2C44ylkPUcYeyTHHI/Fowmof58ivuA0rhEgZQe+kywhz1yGP6dytxBYI
         iOGxcARVKvVhvYevibciv1BwfnCtvissoG3Qbwqx8+aQCsp1wavherFs2MZsEbXUAugf
         0AFurBfSH5bUJJK5ea3Gl2UZ6m3cr0NrvhM/Tkf1/O+yZQQyYSMrwNV3FUbFcTmanhlP
         VyWArOGmvtqhACRKucX6UW9ezXdTNL9vA+GY5EDUXNvhjI5Ah5IsQOA/jauJipvWcOVH
         odawKEKuH8hwj1a7kf0CxIOl5v8vAZ9tLMSl2gMkD1WTuqLUYtSlAFi59fWya0IUlv9H
         xNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351772; x=1788956572;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mHu/6wk7EVyBKthvUsQwwRxIg1oSagtsFckVCW45lBI=;
        b=Gsg5PZAlD6aBgaAHzlv/PQXqaaOhSlz+RO243duuzyz0jdQf/BQFf8QEob5ZEMibCt
         X1fo/qhmnFPPLXFtnAQOunoJnVsROBrqXx5cqYrdniaX8gT6I0gW0h5ZCRwTcx+QAj4T
         /Pq+wHjXvhLfpSnwnWUFOcT0w8ygdJoEX8kRxyE0DLi1HE5iz0na/jjD3cEbmvTWaa6Y
         jcyGcknlGN6XjIFuBtSChIIFnBHnycC1h5RM1MOZ+o6yFMD1AxR7ueQlFH8znl1lus6A
         rwgcjt9C12KpWYqKGYHIMKPo84hIFppC6r41ru3tND1XrLvXexFXnTZtAttL/JzVK8/T
         sfEw==
X-Forwarded-Encrypted: i=1; AKwUvBwMSEWRgnhqSbCmYf3R/9F9i4QhOtdy3PudEQ4deDm7g5Laoq6pMq/02LA3PNo+f7bSkHc=@vger.kernel.org
X-Gm-Message-State: AFuF++kXOp7GHOR0jkFIQJr4YoLwzG8942GD73Wmsk7T+YM5kwZ+KEp/
	OHK0KuR2NWHvFnsds9zI61Wi9gZiiUajeuTRSyQ0Ms5tze59lQWqj0CG
X-Gm-Gg: AYBFou0iN25TSG37ukjUkburPpPc1sA75/uYafq8ZeSBuEz19nvFus24JnlmXOLkCnY
	42GhnVlPE1rtymd9JLCqdMgVfWDK7o5cXAdyEEpNlKpybtqJvrnSGp4ongdB1I0SqyJIABOG3/u
	3oYbTYoXVqO1IrUXareR2AlO4Rpoe6jilXjyolMvnnDIckoDRnEUBZhfiWQlTZvMmB8HxLPhtJN
	nSkwMtaDM9l0B5MxFb5yaBUZyXIyeEalLI19E0DRIO9O+Xbx4wiuZ8YAZ31lbL62oH00vxCJzu6
	xOVS5y0WQarWfSSgPlV6ip99F5jDtQvKuwG2bZ3s72MELLquHjQdCahJ0GAW2fwsJYJEbvQ6Kpf
	zJcAWRds0QzVhjvqU1OzrVZuKJVKPXkexPYdw0wk2RsdQzHRiaq6Ru16RT+DAoWIDSjrO22uySm
	A0+8qVx1zMKN7tSKKwCz5y+zGk4XgC66oSva2IiXqkauGzxsBTZTYUK/d6q5rhsjlFNp0BTV4Af
	9s=
X-Received: by 2002:a17:907:3fa6:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c25dc9bedbcmr160135966b.2.1788351771898;
        Wed, 02 Sep 2026 05:22:51 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.3.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d039d2e5sm122870966b.38.2026.09.02.05.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:22:51 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bfbcf166-5bf5-4cde-b607-a5a038edfaa9@xen.org>
Date: Wed, 2 Sep 2026 13:22:49 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] KVM: x86/xen: Rename max_evtchn_port() to
 kvm_max_evtchn_port()
To: David Woodhouse <dwmw2@infradead.org>, seanjc@google.com,
 pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 ankur.a.arora@oracle.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com,
 nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-4-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Rename in preparation for adding a variant that takes a latched bool
> argument for use in paths that need a consistent snapshot of the
> shinfo mode.
> 
> No functional change.
> 
> Assisted-by: Kiro:claude-opus-4.6-1m
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/xen.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>
