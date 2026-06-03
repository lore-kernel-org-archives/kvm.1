Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAE3FE37B;
	Wed,  3 Jun 2026 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519715; cv=none; b=cTQfbjo0sAAglDW4zrKHWGvStQL4qEQDbXgcGOQ3HdECHGK94rGptItlFAvEbOwe5RLXA9hEE6ZMsf6w3RYxxrhQB4HMdFCMmLOIwt3B9+Jpig3AoyY62iaJ180zM6dyVtAk5fiNCl+oGbVOndauuV2JpcDGECk+tQcsAL75tAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519715; c=relaxed/simple;
	bh=GNhenlBL0E9REIOyjFvPr8CtOZ0gUBPCOa3T7sivZSE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FrcgawP4EP+8fHo843KP1nqcJlJXNt/lkt2ThJ5EFZYF1d2Xm7REBnGpf+h8aKwf4BlGdwZq9KS/dhRZO2JQigqGEJrZFQD2DQal+kNdoKdDHU6kCH/Gez4t1h73mE0TQto5o3OY/XPyLT8ZnfB3V2+zmrayhi+eyKheWxHzvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fYXrVgq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fYXrVgq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA51F00893;
	Wed,  3 Jun 2026 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780519712;
	bh=aWq8G2lqw2RpyQfsEvmjqd0W9Ut7hRZ/L/1V1a9YGeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fYXrVgq6VwBui5CH3f66ph+YRAl8BrNXjRgTtjbvmyh2QsCIioaBSNTbDAAt4dWT3
	 mKmlFk69pBVUjkA+nM94EVfEbmOkDzUep6ki+2imHJW70w1ggs8/f/s1Um+kXs48U3
	 V87j6OBoF0TRT9IjuO5ICyN7KEXfNMjclAJy1A2Q=
Date: Wed, 3 Jun 2026 13:48:30 -0700
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
Subject: Re: [PATCH v4 0/7] mm: Fix MF_DELAYED handling on memory failure
Message-Id: <20260603134830.ef8caf48aff794da581d0d02@linux-foundation.org>
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 02 Jun 2026 21:55:40 +0000 Lisa Wang <wyihan@google.com> wrote:

> Here's a fourth revision to fix MF_DELAYED handling on memory failure.
> 
> This patch series addresses an issue in the memory failure handling path
> where MF_DELAYED is incorrectly treated as an error. This issue was
> discovered while testing memory failure handling for guest_memfd.

Please include a description of the userspace-visible effects of the issue?

> The proposed solution involves -
> 1. Clarifying the definition of MF_DELAYED to mean that memory failure
>    handling is only partially completed, and that the metadata for the
>    memory that failed (as in struct page/folio) is still referenced.
> 2. Updating shmem’s handling to align with the clarified definition.
> 3. Updating how the result of .error_remove_folio() is interpreted.

Thanks.  I'll take no action at this time - it's late in the cycle and we
lack review.

For some reason Sashiko wasn't able to apply this series to the various
branches which it attempts.  Click on the "baseline" thingy at
	https://sashiko.dev/#/patchset/20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com
to see what it tried to apply this to.
