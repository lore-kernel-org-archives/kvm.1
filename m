Received: from mail-qk2-f20.google.com (mail-qk2-f20.google.com [74.125.230.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C142254A
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289092; cv=pass; b=E1IFlsBdq4qpQSJXLgg/gbhyzXZKVApjn4FyrhKHpyKsjeRMlHKFTx5F5C21ykU5T6yh63kP/qOc/oDJdV++oi5yjAOi1UdMfmOoa3U9jTE0fOeje/RgVYo2Y56KpsKv/qAqABpHkgSMaxaN/ITNbh/XLvsQmKxsy06Nvf/4vLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289092; c=relaxed/simple;
	bh=QyHE3recU+YgckuL/EubHuVec7rhNZz4z30xRjcK4e0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nru0Pvn2JrDORdovFwwgJbhFSHvVrP3WM2E9BXANon8YjeKucd0FdsBD7aVr9OyKW83KXVRtYaN9jSOwOcD59Sa60Zh95PVUuiZR77zbL/p6Qo73e1ql1yOEbzq7mSKOr4f9HdJu1r/EJP0T6LCzwSJ2Rue7pWnc2c60kyEgOUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvuOtUQB; arc=pass smtp.client-ip=74.125.230.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvuOtUQB"
Received: by mail-qk2-f20.google.com with SMTP id af79cd13be357-939656ff6d9so30821485a.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 15:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790289089; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIHubTFMBZW0HrUlLUDpRjRjbUtopknh4svc1HHQxRRuXoNlLvjaxsmcOqCNV5hIq1
         jGRjMhbn/QbRN12JyknLF2IdPs00NBXUsfaOQd5FCjKc2GzJ6XQmCOEhXE850Z903dyt
         8PP46yDleHpXvNYFup6H+M4IjAqMD8d6r54YrGGA/Mg2Ogpt4cwRbmTKbTXKGWEj04HS
         AHogEJMG+5Eof23s8y55tWE25xlr3q92ChllpK2KxhGC6TfPRXdzg0yZy0A0CPzSpe+B
         50cDKZpPy2ByA6RgrVgjuzOCHLGHKrIcSU4Rvb6X1u/Bd2R195SZxYr0wz3aSxlyzwmH
         OEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KLxQ1V7eKFjM5hpU7Dk8oYI/it/LXUSsiWfbILSfCAs=;
        fh=Y65jgnS2i1sI+RwACXQJFwvfLrIbpk9uGCp3NqVvGNc=;
        b=TmH0oibcS0ozlm9dyJc9d6B0aLrcR9/VFvkRBppylSuREoFlVqt2BAqL/F/hl2UTUT
         rTWr86IrZEDW0QvdKTSRCtNuR1c+wuXMZH90j7APGvdG19nnEWD83mKCPooal+PfhXZf
         MftY5IW6CrvajB2BuahHZh3qqmvu9uZawACMu1edZya+oXKW0pvpAF3q77fXd/bhhcP5
         v11+KRECUlQ3/iCn4WyaD/fObqBlJr5i/xUIs+xhYakY/syvwEL5lVDBNrijaFvnI87l
         /mfLvtMyn2U4GP7BCl20OFVxR4GUIcuw4dsgpns81mq06x+WucxXWUuajFTroteYkqfI
         jE+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790289089; x=1790893889; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLxQ1V7eKFjM5hpU7Dk8oYI/it/LXUSsiWfbILSfCAs=;
        b=CvuOtUQB/B4NTpiIDVO0oU8xoIsonreGdXZVXw+78v7q5YrW8DRlFGYMCN/VBUc8/o
         iStJentZaoI9twayKt9xqPL4Cw0lEq6J8aWdENNeqkW5iOMhDcHPUuuz+TEP/dzXM+XD
         lOvy2Fxusw/H+NQynYSRCFYhcccPNiOXt0Dquf7WYm9YFLY9RBjgqyEI/6jCln8qG0a+
         Zesms6H6dhFYDz9REiTFRfRUEVG31ao+j/KiuNLF1UOKUsn9vGO2efLveO0xpbRX/6fG
         xoJF9lUTMvbWYpBW5X1sPYcJqRkMf5UvAzUv9NXVa998IVRHpFfx7HABfZ4TNWuvN8oB
         7q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289089; x=1790893889;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLxQ1V7eKFjM5hpU7Dk8oYI/it/LXUSsiWfbILSfCAs=;
        b=m1rzGhaW/upn6NgFltgEGP6kiBCGXUrFYcekT9mjEiHYuNUSwPlO8xan8zOHVF8vZH
         /W62N3qw6huHNP9QJoBxcF0ttR8nqAPTijn0H4JpcsE1w0xM5rx8u3AFcHMAc+WJI5uf
         ZcVksLcXsfSZUwvT0aNv4hG0MrnmgrcPUYrOKzt+4Pl386R1pAblkg5yKAtET3juM6ns
         8mjzXqKr0O3OuRVZkKKLQUpaKA0zaNW0GxltEzxAZtYB+aUCrzE1ol6iUIFE+IxjRe20
         LBQKUT84aGIgKyJYkyyfSiHLRCiIo4n0EIiVPhX4LbPeU0BhuVa5lwWGKTBNGnmhhwoE
         yeMQ==
X-Gm-Message-State: AFuF++keIk6MWzoCmdir4zpTd1J/MLKjo8IivJtuXoLr2GstiBu+F3ck
	BgXJwavDihxrjPdYiq2vQy/sUrgbf72s2Egtnzn9Dlm/QeC9PjKPYDs4XHxyz04Whb6m8SvYHsj
	12HPnXXaZ/DvkB481Qpr/uNbS7EfGj3JRwYKi4qdu
X-Gm-Gg: AYBFou3UKZALFZBtkti3o16BDx1sG6ATk6u2AE3VuQtIkMUBmJ7Zhjwgdkhs2vJocsq
	s/SnYkfawDPvfiVmTR7V/Pxo3Jw7x4uWjVwvBymgGkuhKvE5vNbZocHlPVp8L7P5/KCgmdNI+sn
	9JQQx5N5tCkn/1P7A8MIsQrVioqICyQ3BtUZ09OE+brEWZugKbgbOQFs7oGM33hIE3hVGABc2jw
	5PIp1p41X3/wk63F5U/ThI/eI8nI8m4PVTIpgKYcXYem7uTqt0WBPGRu316nwyKQ+ozaxGKLgcH
	fViA2ujZQjQKGHMr4GFyZrKAOTAh9E9CUNcnctmSHHQmzm9KLxp4nGax8d5fD7Lhwu4/LN+DCJG
	r4Eji+hqrySmfbOvRRvvBofK8T8fZ2uNILKEWj01NPw==
X-Received: by 2002:a05:620a:2b93:b0:936:eeab:307e with SMTP id
 af79cd13be357-93c43cc5676mr141474285a.9.1790289088659; Thu, 24 Sep 2026
 15:31:28 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 15:31:27 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 15:31:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <179028368162.2007072.12117327378679658047.b4-ty@b4>
References: <20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com> <179028368162.2007072.12117327378679658047.b4-ty@b4>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 15:31:27 -0700
X-Gm-Features: AclHuK8DxWsVWtzA-dbMsis8Esd8BT_dOvi97JucFF4AgqprHJknTuuePlOITb0
Message-ID: <CAEvNRgFpMwduvHPGJ5fLoVPr_iGn=ELzY4AcMGHESC6CkMyeTw@mail.gmail.com>
Subject: Re: [PATCH v13 00/44] guest_memfd: In-place conversion support
To: Sean Christopherson <seanjc@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, 10 Sep 2026 16:55:26 -0700, Ackerley Tng wrote:
>> Here's v13. Thanks everyone for the comments and fast responses!
>> We're now at ~3 weeks to soft-close at 7.3-rc5.
>>
>> v13 is based on 7.3-rc2 and:
>>
>> + Hugh's patch to export lru_cache_drain_for_folio()
>> + Another series [1], which makes kvm_gmem_get_pfn() NOT return a
>>   refcounted page to KVM.
>>
>> [...]
>
> Applied to kvm-x86 coco.  A *huge* thanks to everyone who helped with this!
>

Thank you so much everyone!

>
> [...snip...]
>
