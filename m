Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B3247280;
	Fri, 20 Mar 2026 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974355; cv=none; b=DFg2QX9FkPQb77Gj9Fnnz+UKXewJB/z/Nt6KjN35IqmT3s6xiP+2ftxAZkkEgLkR0NexypnTkjM4Hm7xJsh1p7Dmzg7rk5gs0is7y/eEn1fO6oSITOVy6quoNJtiJJfemFFogQyHjiqoqxUf3zYEdDrtgpipt4S7pPYe8YiDWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974355; c=relaxed/simple;
	bh=DI9Kcp+U8vLohFD58fGlbWJnlUtiSZ9bu+o5I9WX6hc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E41aj68vkrwC72/DMPbhZ+XWA17TU1jptZotdUWg0aGYX2/BndcLLePtycjsexkzM6LB5oSzey9ohBWLmI8+/avVxeyqLwcZeFNRmSzdgbias8CWr0/+V01xMMhzp2kdJJSEltnPQrQpF036sGDY+qkuR+RnE4qFKU5fyuEJi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ypH57gKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ypH57gKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD69C19424;
	Fri, 20 Mar 2026 02:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773974355;
	bh=DI9Kcp+U8vLohFD58fGlbWJnlUtiSZ9bu+o5I9WX6hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ypH57gKqZ0OwuS4fW8MKdbyIUFOBAIY62ge8wCa29QezHhC9yDlXbHSuDTqAqiRit
	 0nrRhN4kKvLaF3Cot165iP6LM4ifmdtzdwdQ9o+THs1G+Ia4c8j6RKJsXvBl0+a2l3
	 Bk+Jg3XbtZrDAMkhXknHaU2pjg6/iA+FxqrmW+yE=
Date: Thu, 19 Mar 2026 19:39:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lisa Wang <wyihan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, rientjes@google.com,
 seanjc@google.com, ackerleytng@google.com, vannapurve@google.com,
 michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com,
 dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v2 0/7] mm: Fix MF_DELAYED handling on memory
 failure
Message-Id: <20260319193913.eac97eee63f451ca325dd775@linux-foundation.org>
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 23:30:27 +0000 Lisa Wang <wyihan@google.com> wrote:

> Here's a second revision to fix MF_DELAYED handling on memory failure.
> 
> This patch series addresses an issue in the memory failure handling path
> where MF_DELAYED is incorrectly treated as an error. This issue was
> discovered while testing memory failure handling for guest_memfd.
> 
> The proposed solution involves -
> 1. Clarifying the definition of MF_DELAYED to mean that memory failure
>    handling is only partially completed, and that the metadata for the
>    memory that failed (as in struct page/folio) is still referenced.
> 2. Updating shmem’s handling to align with the clarified definition.
> 3. Updating how the result of .error_remove_folio() is interpreted.
> 
> RFC v2 is a more complete solution that includes parts 1 and 2 above to
> address David’s comment [1]. Selftests are included for all the above.

A few questions from Sashiko:
	https://sashiko.dev/#/patchset/20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a%40google.com
