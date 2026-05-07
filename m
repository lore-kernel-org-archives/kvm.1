Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843D3C661D
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172976; cv=pass; b=jaoriLQyQCr7AK4YrwLg1eFu/q252JqVf/p8OMljSd8ytvWfDcu5D+AD7BbfLeWO60xsFYPMxH+2WtlHY4rwW0yLeH8H63RHhkYnHPrRkUNHVdApceztz8m95i6ncJQm9V1hU0B7+yzy4Py5OvRFD/rXpSeiGOlJwCKOA2gWNKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172976; c=relaxed/simple;
	bh=yU58Xq2jlsKwRvWVzMF/35DqD9SuerVG6YnTfgrQsdg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMYkESBYgFBafI1ivfFRiYWEI9356qfoWS61LXUXkEuBoIRAy4YOKFqD4cOMhi+/Db1hJ2dbS0JteRXvQVJgM3LfGrDliny43kQz9dKl54ALMLmGHkMnKIhD2g2Db9/bFBxfAlzrUCRSxUOd4i1PbstD1TRdwoffKSEWLOWQy/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+qM3eJX; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+qM3eJX"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9568159ee07so631858241.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 09:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172973; cv=none;
        d=google.com; s=arc-20240605;
        b=egtl89zeoLaa4N+VJZtYZzu4+5xgrQUqfDYP0yh808EJmla8ofcL4c0Z+9UnirhZxx
         ijMN0aiF0gUWVGUAsUkwaF/SD3yyGwyZrmu5slPvqivONxxAOwHiMaBmcXEZU2hQeakN
         49XPggrpu9NSR5vNgoBcG7szmmMC1eFWShR4FIkPJK5+CvBJL54U7lWmamPIXRXmOmM7
         YpwsyFhLuxD3/+2OEfR3Eb/LEZ/FacmXNBuNK4AEL3ui3MBy11NbwufI4f3b0es/0kK0
         WS6LYkdfpNvprw1gtsYq7gprQUMyJFh7SI0chckykHz8u6zPZmTEeh8WkQ0SgJcdXn8t
         QMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fxKJNK3JYOXtq/6RpdHSxauIPnnYNnrQjQPiGKEVycA=;
        fh=GVwIAchlG+ji4OE/hk+Bn/4qFWHF1gX5kj7QGkXAA6k=;
        b=FilLkuiqDS5bKAsrpdKhUOQYXCnver5K71HZcm9okmYznbcaOyb6BqHiPoHOH55i/5
         W/DDbitTui3KepqkCQi7wojBFV4PeKOD6sxoQTA2V/iGszUKe6H51sg1zJkEo3ngJF97
         6icgQA1ldDxq53rO9NP3zO0Mm6KTJAaOMwNTEKw4pr5mVOfWhrX7zdZ/yB40AeHm6J9u
         +vOCZedOK4yMHDxe8QQWzN6/azKGUVfm2wX5rrn/92JWScwawANFGy1ybE1H2criVFmm
         ax+UnZNlTHp+D+l5KJARMBaIxiz5DCAGJVHA1K+siTsrdYxw9blmHC/1ViT4nWiEiHFp
         lfkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778172973; x=1778777773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxKJNK3JYOXtq/6RpdHSxauIPnnYNnrQjQPiGKEVycA=;
        b=X+qM3eJXNBkXxwX1JTjGOqY+SYIjD7OSQTTVvvH/d7Nt/MhXpv/9WeJL03HkywvFpu
         lDNyX+dclfgyAnhD+8YhHeNs5NOIBeliQTxtb8XsPAmy168xewtjrqpiDUODMgKv8j4G
         S4MFtygN/7tarwoktBPjP2v4hmJwm/cQhkSRO6F3xWWFtwvysExswW6eESe7LkSwF6ZA
         zTDl6THueBMTmPSkjEHcp50WYWxQefW/LSpbIvVkvqecKpIvnbleFhnWRg4wFwJnVCem
         rwB+sfNX0dtugfmtyQV7/a7IBs7+GPxCDbM5fVrClxK3C8X2tJ9hpm4tNg5S8jMzzLdC
         lIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172973; x=1778777773;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxKJNK3JYOXtq/6RpdHSxauIPnnYNnrQjQPiGKEVycA=;
        b=gnKz/Yeu8Xsv7ivk9MQnms4Ayb/RPW+ys2OhEhcrTuJyL5ZUxztU2DDBkzHK+Sje1u
         ieaG83rNBH4mf0MCOTCXJmVxutcILFuQeW2PwAP3sVxibYfk1ZTRR1XD7JmtcqmEDCn+
         Fr8QHWUPLstw5degncNc2uefcoJfJv4B/cLvUnlOx1QplI95quxuR+y+I72k+chnUimO
         BvbZxysX88/+zdE+zO/Frj+7uEg/hlaFzhZYhZ8QavxYflqyPSj1IVHcmUVKfzSMXl/c
         RN5bJRRFn0OyE+aRJwqtjb7/S7sV4LymrOm0uT8uw8sf8XLJpaLGziwZKoBkhCk/4Juc
         7uLw==
X-Forwarded-Encrypted: i=1; AFNElJ88H/gE/vYusYoJhjxTBLPVYGuhlSxh00CBMn+7WaxQd7kw1rvNuZir8EgKAihD9NTs0c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UkeT//R2Bzo6qNYPGDK3OpKpFq65xGtPJKCdvjK6Lrxvz8HL
	EfqwL81AJt6Ijmvq1Xvz3sF/m+dFqpEJ+DxhmRBFy5XeClHs6esSztyaDBEM2IY9YhWAVWhBPy4
	X78SGmV4VbaAXhYYTEhOofnZG5ff9azPsitnDbVxe
X-Gm-Gg: AeBDievZOsHNH85+nw5sZ8W3R9/sT5IXsnjmXVi13ybmSI3gB1yKoYZOtTMCYpdU/M2
	IFc3XtpIzLl+LB3+pdFjSzKPUSxflB/e0GfgplRHOBbA7oJdb+6/kfXwBZGugHYBGM5o5Pe4F/W
	MyTfk7MSXEli3UXTAAzwaUK9iOuIvi8aM97A6CMyZzye5DHN0JAS/s/mJVunQtLY8DxOQ4TK5Gh
	eOs30PdhlMIE6szXwHfsv0OPnFo4+Ijtzqg8boed9rsVPY3qTgB9iOX86F6CkdQmLiqkixBTGwp
	dZ/1QA2jz9fHk/m+SPnuTTVvUF+EkCZY0M0DaRsMqI/DMEHlBWGKLaZR/Z7HWKGrJGk76uKnHal
	0r081
X-Received: by 2002:a05:6102:3f52:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-630f8e78530mr5085650137.3.1778172972306; Thu, 07 May 2026
 09:56:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 09:56:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 09:56:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <n5ce32wumzeiqqyqutom4apy2kqfetbvusc6j4k2xarsska5mw@klp5bmy7qhfm>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
 <20260428-gmem-inplace-conversion-v5-10-d8608ccfca22@google.com> <n5ce32wumzeiqqyqutom4apy2kqfetbvusc6j4k2xarsska5mw@klp5bmy7qhfm>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 May 2026 09:56:11 -0700
X-Gm-Features: AVHnY4IiEmQejwyUzKbSGtsBzFH7WMpl699YC0dogi8imsP9-pFhPzVdvXeVDZc
Message-ID: <CAEvNRgF9+Gr7UVEq-E2SQEb_XOQQMOXy9F_A2tA=DbNV_fJ0EQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 10/53] KVM: guest_memfd: Add basic support for KVM_SET_MEMORY_ATTRIBUTES2
To: "Liam R. Howlett" <liam@infradead.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Liam R. Howlett" <liam@infradead.org> writes:

> On 26/04/28 04:25PM, Ackerley Tng via B4 Relay wrote:
>>
>> [...snip...]
>>
>> +/*
>> + * Preallocate memory for attributes to be stored on a maple tree, pointed to
>> + * by mas.  Adjacent ranges with attributes identical to the new attributes
>> + * will be merged.  Also sets mas's bounds up for storing attributes.
>> + *
>> + * This maintains the invariant that ranges with the same attributes will
>> + * always be merged.
>> + */
>> +static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
>> +				    pgoff_t start, size_t nr_pages)
>> +{
>> +	pgoff_t end = start + nr_pages;
>> +	pgoff_t last = end - 1;
>> +	void *entry;
>> +
>> +	/* Try extending range. entry is NULL on overflow/wrap-around. */
>> +	mas_set_range(mas, end, end);
>> +	entry = mas_find(mas, end);

Thank you for your reviews!

>
> Please read the documentation as I believe you have a bug here.  What
> happens if there is another range stored higher than end + 1?
>

The invariant in this maple tree is that contiguous ranges with the same
attribute are stored as a single range.

The goal of this first part is to get the entry at the index just after
the requested range, and see what the attribute there is. If that
attribute is what we're about to set, extend the requested range for
storing to the end of that range.

If there is another range higher than end + 1, with the invariant
maintained, that attribute has to be different than the attribute stored
at end. Hence, we only want to extend this requested range up till end.

> Do you have testing of these functions somewhere?
>

GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4) tests setting
attributes in ranges. If test_page is 2,

1. [0, 4) starts off shared (4 is the number of pages in the guest_memfd)
2. [2, 3) is converted to private
    => so the ranges should now be [0, 2), [2, 3), [3, 4)
3. [2, 3) is converted back to shared
    => so the ranges should now be [0, 4)

I verified this by inserting some trace_printk()s and inspecting manually.

>> +	if (entry && xa_to_value(entry) == attributes)
>> +		last = mas->last;
>> +
>> +	if (start > 0) {
>> +		mas_set_range(mas, start - 1, start - 1);
>> +		entry = mas_find(mas, start - 1);
>> +		if (entry && xa_to_value(entry) == attributes)
>> +			start = mas->index;
>> +	}
>> +
>> +	mas_set_range(mas, start, last);
>> +	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
>> +}
>> +
>>
>> [...snip...]
>>
