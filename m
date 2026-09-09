Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33494A2A7C
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965569; cv=pass; b=kEAbmgd89B6Ccg9KzXVsJL87I/uLSE/IItUU2oqUyfDVwj9N+jGhw/n8+M6wGYZXVvAsU4cw2zbtv5FSetLwbUXYCpNQLHgeutO5Mm9azl8T72fS65n7Lfq19fDpljRwKtmuxvS0i2L0rgpk/fq1aoNmLcymL0I9Jbv51RDoS7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965569; c=relaxed/simple;
	bh=nlL495Rwgq5pTxpggaWR4Kyh0bctH6OQcmcJP4kB+LI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3PO5X0Q0wDeKkwydc/uRZ0Ngtn8XFQL3Tbs/CDvYwKhDqf9lN6i8R0C+EDJwfNEGtoXHEYizJswjTrwPBpiT0qGY7zIkjsI+CWWL+z3p3qPs69+6YsNytHwJGupqCzbhnKEMEf7LxrggNb0IQDl3v1RsLmMiq28Rmb7rXt+E+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8i3qMhU; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8i3qMhU"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-855c26cf490so44341557b3.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 07:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788965565; cv=none;
        d=google.com; s=arc-20260327;
        b=qoZn4aO8awyO2E1jFt5VJxxoGPvXFFUeSmh2dF4WZxvDmzsiLnBwnuWbW1K7W7apsB
         CHa2D0yLCBVsSaQSCh+Xu2IJyuQzc2Vi9f18IjMmceQnmlHI5Dv98GgR5tHBw4tHnJsE
         TqRbMWgAKAPxXACEkY6isEtpCaFDBbWYfaW3epJ5/FEi6AnjRH5M/wOgCYw9tKV7Qsjv
         Qsjg1YTB0riHo5QrK2KImIBS60HWsatP6M0u+2zXcmzIllAqJiub5vfLqB/mEtNxicf2
         AmyYQ5CHmoGbqSuxknmicc8drpheXhxSssqm9dNJYx5VRqCsm/aMXlh6Px6xub5wnDAA
         sP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QRvd1Tt7kpHM/AxQHBaJz2yfsVBadJLI9GFkxk7vpJA=;
        fh=h8rNAIkXPvjXjMwL45WXtg1fqzsX07SXGsz4Jyxnhuw=;
        b=KUWhcUJ49ATFziDudHIEQV5ekPU+Z2PkSUBdkUGc5/z91a4xP5ind9vH1epivYJ+s+
         etDDUXsHH8FKsCR55D4OJox+B/SSzbrBVE6Qo7ZqhIOa2bx5DEblCAUfvckeNnJyPMiW
         tfjy2xg/6HYMg/Ej2wMxXO6tfSVuQZuI3ggn2+Eo+DAjqAcyrDIADOZ5ilNdvz1HQp+J
         irZv7YYAhbnvoabAC5che7tvUDjl72gCInwS7AwLcjEQjUnsGdhBf2j2hVjrZZwKorsz
         lJA5hDOFuzhNZUAV6LZ8PYLjcc4SPoXds2Y2zHjCEeeYaTSjW1bo2ropNqoi9aRnDUM7
         k7Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788965565; x=1789570365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRvd1Tt7kpHM/AxQHBaJz2yfsVBadJLI9GFkxk7vpJA=;
        b=q8i3qMhUp5t5ZXPUqJ2Q7wyst4pkqzz6PPNiA9qPABvr5TxyN6xE+mJfG4pvM4uaZ1
         hXgisclAU/Lka+Zv9mMs6hWHgsuGeUiSnXazvtjRlDl+mRcyhK0QxGsFG2fOHKEJuLDa
         uSnTA6nhxga6hmxGoPw6Bvm5LBSqKV83ZZFkqSv3vX8KHfOO6/t2ZvUNFNJbwxl7oaU8
         cGzs9DnJlC6Bly13MaOpMSLyMWnKPMOMtGDtRzL+H4BuT2m4ucPCGKrl063UZ+FXGWOO
         HUnv3V4svnbBaQst4Gv9XvhVy8D2/4PMcgO6j6/BMPC0aGQEZjOtYe/60bQqzO9HDEVV
         X3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965565; x=1789570365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRvd1Tt7kpHM/AxQHBaJz2yfsVBadJLI9GFkxk7vpJA=;
        b=qjhWSTVDthkO5Lsr40iAZlgoljCS2x1RECEHIfKqCldJrVe2ClYcbkQP+rRjqsYtkS
         SSsPgCMsiAA0My/3FSH/6ICmg1ON5gP9O8F+LveL+J9AI++7G72Zsy14J0rD3HBrepJ3
         W0owF5L58eoPRHFHD6L16PDyl2Y0+2apv1M6YSotTHoOg6JmrSEieLKy+UnOFZFxATFz
         gQ+53Yn6bOqbZhZzdnEb7IMwHLYejCqm4KoTG2Y9FHUXE+2uoSGWB90L0jw26E0tmX4j
         I+kOyiskp81DVb+rkSiHLYEqL5BEtPfnXLQtMlIKLyaj0HkienJxwP6bx1plSFC45oTC
         UUNg==
X-Forwarded-Encrypted: i=1; AKwUvBxH7c9twe2cpGETJpBFJX4J4jIkAQTVhvP8rkqIXE3Ed5jswqut0CbqAJjXL+I1iVDDHjc=@vger.kernel.org
X-Gm-Message-State: AFuF++kDNMNwE+mlA6IlY9QS9GofTS3tT0HFeQ9HUoNWG4UUfkJ6iFZ4
	oDMNj/HpMBte9X/TPQGTStMNhtD7S8GElsgD5+hjjVnYjojQnVFDh+hRiaOxukLceCUXtHegIHw
	rENO7SLFCWJczaR44n2TqDsPwxd8cESTtO26AoW+C
X-Gm-Gg: AYBFou2Zg3OAC87X0mS3CLuR7pYEEuCOzVgvAKqEn8yF9fRA4teFTcw/fZMEi2T4OOs
	7yaCA37RGOZAK8szeVAjX2knoAmeFDqMOk8uCmSSNR91uyRrT/CeBH1xJn7I2I0RMY0TlfnpJCH
	RWPu4eOOui3Km84IS7O68AapReMD1NnzE0QvJv8hXSX4OOzwyOaHACCXydCwVX67wFY9PtpFsGG
	xxHTA2cVoIun/Xxx27I8V27QZDCu3McO4Zq2/hyiAvOlARbbL25LFbqAcLIqi531Iwjb1o6vmns
	yU/H5w4qXmlaRUFi1l3flwN+N6YeA0e8SFbzQ0sAZhhCNi+e3eHUZ5HQpfh0t8IdBPQLv8ePLve
	3BmYpKA38w9Q=
X-Received: by 2002:a05:690c:6b88:b0:845:ddf4:a3a7 with SMTP id
 00721157ae682-87126aa77dcmr145268997b3.16.1788965563207; Wed, 09 Sep 2026
 07:52:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 07:52:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 07:52:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTyU1Ldbw-qqdQOx_P8jrt85QEcKSGae2h+AahsDQdbmLw@mail.gmail.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-14-85e5fd25252a@google.com> <CA+EHjTyU1Ldbw-qqdQOx_P8jrt85QEcKSGae2h+AahsDQdbmLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 07:52:42 -0700
X-Gm-Features: AcwNN1XhqWHW23-sQN5ajMsWY1WhBdcubAUAi4IgbeOekiJ8g-YJ7YTjJ4UYzFA
Message-ID: <CAEvNRgG36aXk8UW=Mi7ey-6vUe1EOKnkgNRNzdSUz-QJih4uAw@mail.gmail.com>
Subject: Re: [PATCH v12 14/45] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <fuad.tabba@linux.dev> writes:

> Hi Ackerley,
>
> On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
>>
>> From: Ackerley Tng <ackerleytng@google.com>
> ...
>> +.. _KVM_SET_MEMORY_ATTRIBUTES2:
>> +
>> +4.145 KVM_SET_MEMORY_ATTRIBUTES2
>
> This section number collides with the existing 4.145 (KVM_PPC_GET_COMPAT_CAPS)
> below, so api.rst ends up with two 4.145 sections. One of them needs
> renumbering.
>
> ...

I'll add KVM_SET_MEMORY_ATTRIBUTES2 as 4.146 below
KVM_PPC_GET_COMPAT_CAPS. Thanks, good catch!

>>  4.145 KVM_PPC_GET_COMPAT_CAPS
>
> Cheers,
> /fuad
