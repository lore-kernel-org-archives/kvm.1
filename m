Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561A37883E
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217002; cv=pass; b=VJMuPD3CyUcd+WK9xoJLzGNEBC2oQsDQ5MHMQTtuFGh5XKsI1t+iqp5JYjzZnTD0AyPw/M7pEFgpnu0bsrtDP6Mo1pAK8m+/DBwUhhGrBhfYVq10aMQfxbL2wOXcM4jax4o0nglrQUu8bdtxjAnayzJxWpG4EpL/zdyPemS1R1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217002; c=relaxed/simple;
	bh=VoJiSYHkyb93U+CpFIcSkKKZJudViTXrBB5J9PwFeQA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjOFLHfXIY9vo1pWTwA94t4bp1I//SrhgLWT5789DZTY9GfPDIrpQPpDEGAwOT5goYpTV1gGWAlpzBTmM//kpGWfRuwMrE3aURAl1OZ0HayluQkME3ba3CPKi/oLuXGjiltoBbfhYjxW57o/pk/vFkgikFqXfB9dRmQBVYmNUWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K58qjznf; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K58qjznf"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57512b86273so2890343e0c.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 11:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217000; cv=none;
        d=google.com; s=arc-20240605;
        b=fcYodjyfrWSzVhKbLLIx9GC2PUxSfH2FMSsjbVRC/88L2GzpDd36nX/Sky7QkGCkry
         buJBQJNbatH8r/HJB3228aKSIyruafLWGljLDrTO/aOG0By69Pw2jWnZOE3r/ABDcox9
         fg6jzsytrjA+rAoB8rQZbUJrqAJ/WQi+azHQyWnEVQkw3OANo7IdqtjhPyz3tlW/g1Fl
         wVl4BIeXgcJJ9JoLCahH8dZ9KJqNXcbttLEJNeH7qX1NqDRjEUPYD+QzHPdwPDhjB3zn
         5vKqKaoF+UoQgbHuV5Wi22DxlVnI0NikRCCxb0sWbP6EwIY193dXy3ZCxh/0HzK03n/q
         SEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZJ1om1XG26k9c/pw0fQSTui/sos+jK8LcvkwRi0HW+8=;
        fh=ci58xLF2nPSqc3jQ+H8ad1e2GnrvTL8ScusbugXlSh0=;
        b=lWdAPLf/tVjFO6vgtgYVtB5lqloEQ99DGyMiOsIMlK+494vHsUOV+qBUb1i8TJJFB8
         m0pKMNq//kszK+rrEV/IQAJ19B5sdKHGtfwuYkqs29sfY++9zcstJIR1oIfL+GSK8rFw
         d1lU3O7qz3pa7WD1bWvKuu+bo4nRX3Fq4gYCx9hceO+a6YKnuNvbb43Z7/HtbRe4P5NL
         SdLKTGH378wTBAEjT3aeyYF3GFctPivXI6GaWycCSnvzXKOUlaCzPerMk6dVM1Zu8uy4
         U2Z7sLo89TQY/mfVPvO5ZwR7kPFbMeQNTc4YSEL4ucbMSyXUa01JCuz1tPfz8QbhytNa
         eW5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779217000; x=1779821800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ1om1XG26k9c/pw0fQSTui/sos+jK8LcvkwRi0HW+8=;
        b=K58qjznfIkYOiC1tPg6QfmGiKQBWgkIc8INR1T4iaB07msA9+eIMYWKbhbpbDPtjJN
         CC4LAkCx9m05s8Tt/JMHarvQRABgBeTu7voCDoZKLB6GlBq83Zq1yF0GgS80R5/RIE7x
         b6lNunUiKHyKEUIDKo9h2CCeMumE+Hxu4Fo2rxRqnIS9l6rWNnmI3iVzBwrEhuuEV5y7
         nYxyF+DJCYVrpIzX9RxLrlMQPtTn3TyYL6D2SZfzpz1/RVRfd7CJycQdkU5EW7ynD9Au
         y+k2U1BP0o4Yv+OcAzP7cjZV0k9jq3lwgNBHUiUSIgmE0aIweyE9QMMGXqA5U478nEPi
         Uokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217000; x=1779821800;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJ1om1XG26k9c/pw0fQSTui/sos+jK8LcvkwRi0HW+8=;
        b=atVTqHqPSL2CLHk/3WW8+lBYqhwPhT+N/IKOJxFXD/Eq9ZSfzRYoRpA7W+rryemRGT
         U96AFfFmQY2pBwiP735kDTf/NS7OrJL3+Yhzng9V0uClNxaPjHkoiJPzROA3nwvWC5Bg
         ZW0y74yXaBtjPWu8TFI93/2Y632ZYlqw/WvqtqDYO/4JtVKfj0frn9HsA6C39TVaxDiH
         qvBW2s7u8MiYdjlg+ASz/0IZyMyvqMNFOn6Pp3Gt1SFCVkBRs1OYRDzYfzp39vNDsHuM
         rD7WHnT/BNVCdyYHjzQAm68SpO01P5IJDMRDPsS1ZAO7D2JyvD3pHe253KFb4tXNYfkv
         KBFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Reext0xFfUFy9PStqjTmE1ZCQfswnc26GpaA4X++MwWTEuk1wf2Vqxngrq/8LcFw5MNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7DGH6uve+/nB9zoEq12PZpiFiRMVo9JAjvDWNPY4VRvdc79VJ
	zeUuFzfXPLKeDY8JSUATpx33ZOswORe8KbnLFBpxk2u4Fz2D6PiqDxSUYj0X+G7SCIcAT6KLhSW
	DkMhCvbooeiUKtXNz1ajmTEWhdQfuRt/rs1TMKuev
X-Gm-Gg: Acq92OHj87O5iPz8Hlr8O3NMrVPwUreFEgQx9OjTqOROl/toweliihXmEDW7fxX6cTL
	1m8BCNRJ1xeqlTDbK/aTCpNmjKaAUGuMWUs5PqWVA7Jj2OnTZWGdyCyjE8/185z/lvgdxrY9y+c
	qQtleJOf36U5n0sol5d99BCgW5ThMqeYVZwqQC58W9f8X8U4uqHFf1ZVKCha5j8JuOcuC+Ym3cA
	sZ/XKXPhL47ahpw+VC0/mp+mBhPekHDdicw63zWhXz6YFzY3Wg+5eRBm/XqY2kpXez0NuW7u4Zq
	K6iguny7IOBXxvrj+1VmuaCzhRSC0ZL/Lh0mae3fRwkQ9H+39E4cjcywn2V65Z00nD0vtjXde2L
	3TWwO
X-Received: by 2002:a05:6122:d86:b0:575:3b1b:ef01 with SMTP id
 71dfb90a1353d-5760c0a6a7bmr12548926e0c.9.1779216999523; Tue, 19 May 2026
 11:56:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 11:56:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 11:56:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <agt5wTK5I-FvlB57@google.com>
References: <20260402041156.1377214-1-rppt@kernel.org> <20260402041156.1377214-14-rppt@kernel.org>
 <ac7oE_1j6gxf8OKT@google.com> <CAEvNRgHd4azPaMddvqnSG+Z5fmg+LWd+pz=LSB3PrJTW618dww@mail.gmail.com>
 <agt5wTK5I-FvlB57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 11:56:38 -0700
X-Gm-Features: AVHnY4LPzDj9g5FV4_YaYz9tvR_M1MnLgRQGl6BwcjJkV-QhnQjrw8WLfhjN4fQ
Message-ID: <CAEvNRgE+xXRTWHzAetYhQN-OeTHipspbfvYNzaExe89E_sRkBw@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
To: Sean Christopherson <seanjc@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin <avagin@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, tarunsahu@google.com, patelsvishal@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, May 15, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> >> +#ifdef CONFIG_USERFAULTFD
>> >> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
>> >> +{
>> >> +	struct inode *inode = file_inode(vma->vm_file);
>> >> +
>> >> +	/*
>> >> +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
>> >> +	 * This ensures the memory can be mapped to userspace.
>> >> +	 */
>>
>> Is the principle here that any memory that is allowed to be mapped to
>> userspace can be userfault-ed?
>
> Yes?  It's more the opposite though: memory that can't be SHARED and thus can't
> be mapped into userspace can't possibly support userfaultfd.  Six of one, half
> dozen of the other, but I think it's important to highlight that there's no
> judgment call being made, i.e. we aren't deciding to support only SHARED just
> because we're lazy, it's a hard requirement.

I guess this series is only intended to support some kinds of UFFD, but
IIUC technically UFFDIO_CONTINUE can be used after the private memory is
inserted (e.g. for TDX live migration).
