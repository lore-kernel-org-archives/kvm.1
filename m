Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D171FCFEF
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346792; cv=pass; b=YjwutbJrH4OvVR5PCySqPXgTNOKeluyVUyHQS7M7MJRyWFGqKw7Tm87KT5UD3lAMZRoF/lpYPGitGJ1Wtt3alYgGRjsObxYoHeMs52/fX9ZnX4bqadfMjQTkGU3T86DCWotC3cHZJ3I/QSbKK8G9QjuQJDKYlnbDXh3wXLPloZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346792; c=relaxed/simple;
	bh=rLzvOJxIQU3Ts0wS9KKJCuJPkhIJBlsf6U32nXubaQQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6WbZS1C/qXIhsgYvMmDcOdWXCqUBIfIuPtFAjS5oaWaGmr/bahjwwrdTX0f6DLqwlY93SDfBWJYUpKKe5NQByyoTvXrDvhLWQ9aWkycJRg9ULHtXJ6AZxj+/pmTIKlmur4aZVihJGusODCzrHqL1KEXYXmtZQQb2jucCtKcET0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6SJ8T8b; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6SJ8T8b"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139986373b8so2266434c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782346790; cv=none;
        d=google.com; s=arc-20260327;
        b=BYAcs5Ih75M39V5eO6eEOUCb7yTXrrOA846jYcKut2M/56RL33u2J9IWZNY9oOt6zI
         sRKI+fDX9v95gz5ibOlFKzdoSKj0hbvJzUApYoh9F3KSSTjNZ9NQGADNIvrT9f0JSHLi
         PrQcXbJ79/WtkgC8gOUbKf2OCa130qJFWayVPTVyaW2B3SG5URBIQjlvdJFicqoII7Qo
         Z691J+Y0KJlPD/dho1twt8glRRDisix/Fjo6xrMQLcS5vE3PCVhJV7WN4xbV9DnFRydI
         S8kO5NTHqpM3sVDmgUopYCcfJYfvEeFH8vO72tOB4TlbqYpu3AUi/WRZbumSPJeOE5FR
         jxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CdGA3bllvZfq9+oq5ATtnUq0c6NavELb8bI7ZCuFA30=;
        fh=2K40lVW3hRBKd04REu2zd5qPplu5WErb9x9bST+fnHk=;
        b=cfx4DW2pXas5U2AFXMCSP8cB4gBAlxcHP9TPGQmrm2eT4rNF1MSINrkHJ2NshIIKRZ
         u+zNzDDRij+V+ePCN7VWwd1o7iU0Kyqf7q6XR9QrTWn0RwW91VrjDWW7mnzCLwqEvOFD
         0SZiiJECp1thWFQKD5KDPXFyefxfqFzQmoceKaqQWu6qQpFYxcGBeQF8B/0bXIwTPka9
         yNMOTp2hEY23dijYsOIjKjoAY3xImyXHhaV2g08W/WVdaJnaEIG/ys3yBj7Km2zJoDcr
         3nfdg/qyelHWuHFxflXquaDQe1G31d1j8t1sqKFxtphj8K0IKUefkN9e+1sz6idfOvdH
         RZaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782346790; x=1782951590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdGA3bllvZfq9+oq5ATtnUq0c6NavELb8bI7ZCuFA30=;
        b=d6SJ8T8bFXONBDv8sWkZAq4UxMY1A+sKJAuHT6rEAa7dMvyVDEJrMh1ltaIaSfuquJ
         edvG+HIKuITzIffmOLmoKSQLPZ/dt54ReDIf3J2wnsRdhVmFvN9X5RQdKHO3Hjrz3o2L
         fpjxSMr3L8Ohxdl75FruWF6/Ned4s9TUgu1wtKXLR0M6y1ZjRFiAvapds5FbrNstpsZq
         c7r0yPZqNWvF9p1/Ps+v4YJby45kyjrQpZNQ4yJ6vDfcLnF1EkmBQRaia3NGo1HqfLIV
         h/9MjPaFQ88X58vnGtO91tzkrlUTPflsbxRF27DR7/Fj6XdjYStQIF4j7f7WMalRPUIJ
         NC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346790; x=1782951590;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdGA3bllvZfq9+oq5ATtnUq0c6NavELb8bI7ZCuFA30=;
        b=Z0ugsiGKwvSeSnePHjdt66NHE3JRzgqjyDfJJWDchKfboUDEupxrR2iLxlkQp6qH1R
         w2Tj0Tkgth2DpntutJf/gjpqxNUbdw12gyDYYOHAfKyIzKM9T9GrnFym7FvM462V7cB3
         eGbqf225/+pQTV7XG8YYOp8lPpPc17KekyS+SenDs414dSs1K00EP8mD194YaDSCFuj0
         R4y1tgAMzNBSfKQzzkfWExx+gTsOnL76kjUB78RhVTBLeMvkMk8KWGOPqgwK61z53WD7
         bM/1horVnaSpG4fMmQ/E49A0YsTQGjJKxeOfUvtb97dl2KzyN4ofv/vxqM5uAksz6eRC
         BYCQ==
X-Gm-Message-State: AOJu0YxRtxOvR7NFFeHn5Rs03t8ChImoKXIep66gzbUhg3aqV0bl/Anz
	WtPCMNrHCXlbe5A+GndTO4ks5d2admc3rMn74MaPtgMIWYGkMm6URPmvZLYolPahvFxRKLOrHOC
	6nPZE3Bgu0/pqEokqHltJ30/ftU9XBdeoz09SbXBu
X-Gm-Gg: AfdE7cn5OK141Ge3ulfcGsUJj+yWeape/P60T+11mvznoThecL+qv+u+RSY5+6JK7jl
	Dc+xs95R1TyZDno/pw0F+Jv/oxP3lltWZDf+sRIxjtwJP/+/AQL6OU94Pf/3FHzRWJCk+WgLpqw
	4yM1LwTNnhcvzMXQaJcWgQrDZb6nos00oBOzdA2oL4rAHq1XQzMaPrgP7LpP6DTPKdn2z0AyV0w
	YOAciUXhyW88ORxOUW6VvO1OV9slMAnPk4cVzAnz8dv8Rf03zIaosxEr7LFk5LDBujMapy00z6e
	RmTI7EzPTRi8bJcihRCjFoewlIJsVpqnhYIDt7Fb6dYjaW7KKkxKje9/E7w=
X-Received: by 2002:a05:7022:611:b0:137:f001:fce2 with SMTP id
 a92af1059eb24-139dbbc564bmr255822c88.33.1782346789006; Wed, 24 Jun 2026
 17:19:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:48 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:48 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9f81ea12-98c4-4ce6-a95e-233851dfe8dd@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <9f81ea12-98c4-4ce6-a95e-233851dfe8dd@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 17:19:48 -0700
X-Gm-Features: AVVi8CeR8FAzeQAvNnM15yag_GxBRrpO8H44tlQVk9R637S1b27Bxjsp2TDXvkw
Message-ID: <CAEvNRgHR-6X72fvx-4s+RrsMHohSCBu53bVX4G3x-=XGLnOxiw@mail.gmail.com>
Subject: Re: [PATCH v8 00/46] guest_memfd: In-place conversion support
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> TODOs
>>
>> + Retest with TDX selftests. v7 was tested with TDX [12], but the setup there was
>>    wrong. Conversions were successful (no errors), but the shared memory being
>>    tested is actually in a completely different host physical page.
>
> Glad to see you knew it already (I was going to report this to the
> original POC TDX patch)

Thanks for reviewing!
