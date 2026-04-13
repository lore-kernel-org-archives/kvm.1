Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355A40DFA7
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114525; cv=none; b=oRKx2M+6cvxI+250OM3FKoMUSaOIBr6Vc0w3QaUOF8Nx9o8eJoz48TLGkJMhMuAweJzltGISO/uNt8T85WocrYi5hKxVrFszkLSWKHx+Lsqd0Cvuzx4xeNmQjQe0cweLgyQeO9biiQUYlAD5FNV/E9hZGPEtF/VYXWnVThwsr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114525; c=relaxed/simple;
	bh=uzaVRNE1m2XUCN2Kv9goPe8pl1LVJCme+29/B83c9pY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kb3tpTyeLGNp3TDp6S40OCFIyFwml82uUJUR75tlnUZbi4yFgu9UCqXLDzh9CLlZrDAjOYrQxtXUXhAqHGYM8Pajk+JDeNIHUuDtlszEXwaf8bne/ez/Zy/weOvZFC1rXWI2s933Zzc1K+/MQtA9P4rm2percCvSefjZKS9kNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OObYOkUh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OObYOkUh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so1244093a91.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776114523; x=1776719323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdsNO9c2Q5NZsN7hZZ5BDljOzEMaKqWGBnMOCrBmEmM=;
        b=OObYOkUhBdlAjqmIlDRIKBc4m/mXOHDYOwJsS9Ip566cebqPA8Yr1S8QlsbgCjpWjz
         npfZ+tw7NZ2RPdhwWehBG/5a5TiidwnmTDSz6fxFXP422ZzEioLHXJsuZffiFf6ywZD2
         gZLIfzLgX3iyJpbTyX8v8q/9KDlzVXoNlg4q9jn/W8dgW7eOOsy4+Rusi5rL+avtpqKa
         j+E6oKfpD894oXoWAqiIqP/02Lg45MGqD4w1e+U0qJuzcMdZA6lKYt+IwvxxwjLXzg1r
         rCK/2WUM+Qij8tFwuG+jWb8H/M83YnxldKEpPtf0ffrVPnK9RfWk4UNuNzXv9/oDW+SU
         B3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114523; x=1776719323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdsNO9c2Q5NZsN7hZZ5BDljOzEMaKqWGBnMOCrBmEmM=;
        b=Xq7ORpnUCihqcUUUc+pk/O6KERZpZijYdx6hFAzcIDUuMEynn/+6zuhfo6mehM8iwa
         8sbkn1qUNmxfmQpEhz885HF8WyB2se/IUTOe8CbAh9lYn1TcsKRLa6Up/o9PBrF0wWjo
         m8iW5bnZMz1aGMRUqAx1f6yWwNSGJ2UF/LWVDaQlgxett+JoZDMf3xBqP54OwQ+51L9p
         GVoQCOOgDclVUKOqEwOOSOLovgJDDRC3wzlweo0nxs37mVKOFlz2Nb6x8aK/1IJaogA5
         PJ+6IOL0e3l11sRZ92DJYQ2SozfJMyXPbfkpCzmQunkGCrZDSf/ii6xLsWr9iT9geLTp
         K+BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hjy+cPtPyRE2vZ1FIjKlCx9SN3Xiv/TBJTgn0xRhL4jYjM+YWhhoWCpCW7zO2LipmT3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SDQxTjco95Pn85nghlX/YzT2V0gsorMETm5v3TnZL35KgaC6
	LT41wRryd7N7ODH4N6QBv6kmIdqO+cciejKi98eA7rtzrc4q9E3PfksEppolxN6Gma9YZWkczvZ
	vS/Lhug==
X-Received: from pfwz16.prod.google.com ([2002:a05:6a00:1d90:b0:824:a65c:adf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3384:b0:398:aea8:a9bc
 with SMTP id adf61e73a8af0-39fe3d0e025mr17171043637.18.1776114522737; Mon, 13
 Apr 2026 14:08:42 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:08:41 -0700
In-Reply-To: <CAEvNRgGz6CHgCtR-PpyiRDy4tMioTGgYDFrzuWCmAodMcg5EWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
 <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-6-718f45eb7c75@google.com> <CAEvNRgGz6CHgCtR-PpyiRDy4tMioTGgYDFrzuWCmAodMcg5EWA@mail.gmail.com>
Message-ID: <ad1bWceUiQCtnDfF@google.com>
Subject: Re: [PATCH RFC v3 6/7] KVM: selftests: Add memory failure tests in guest_memfd_test
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Lisa Wang <wyihan@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rientjes@google.com, vannapurve@google.com, 
	michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 13, 2026, Ackerley Tng wrote:
> Lisa Wang <wyihan@google.com> writes:
> 
> >
> > [...snip...]
> >
> >  tools/testing/selftests/kvm/guest_memfd_test.c | 168 +++++++++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >
> 
> Hey Sean, what do you think of adding even more tests to
> guest_memfd_test.c? Would you prefer adding memory failure tests
> somewhere else? I recall you mentioning something about there being too
> many tests in guest_memfd_test.c already.

Hmm, we're definitely accumulating a lot of individual testcases, but up until
this one, they're all quite small and so there hasn't been much motiviation to
split up guest_memfd_test.

But this one's quite the chonker, so I'd say yeah, put the memory failure stuff
in it's own test, especially since testing the debugfs path will require elevated
permissions for many environments.
