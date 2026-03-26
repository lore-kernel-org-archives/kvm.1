Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9E3A2560;
	Thu, 26 Mar 2026 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567424; cv=none; b=Oal84bHtVMncgCDxZsTxxUe7jRlwRdBItg6jstacQsxAkP261PKuccsqu61YE+RBZ/tYOIGbEhgH/svbhms+Mx5QCD/M/Z+hpkfEPcaYKeGdhZ8nM3bgObDKfa3IR4MYC64Rikwb53VdRsPNNxJSuS+U73KPJYhZSPFCDdNXgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567424; c=relaxed/simple;
	bh=ywefAlrhCimBtUrBIPGiIi039tfFwchTq617Tcwm5Zg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=okVHp/5FzVRAA8Ji4FbJYBg45DLtyRfKggn6BnZWqDxQpHIaDCO19p5mJFnsODiFj4cvy7bOFA8zw8MXlYwKAK6bKUW9PpCWxHWzBDHqDTpS3T670G/aF+PUy/4mFYkqZX5J6+wIA3DcGitc2rcELDsgX3a3Iw3dAewYaCDA8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bXZehikS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bXZehikS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57D4C19424;
	Thu, 26 Mar 2026 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774567423;
	bh=ywefAlrhCimBtUrBIPGiIi039tfFwchTq617Tcwm5Zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXZehikSOnzJCjqTWi0vMkzNfGuZk/eIT/VwIhjH+YfQJA7FfwufOkVdraXZLMtit
	 UFempOXqyIbWdgsdvIhVsdje87SqXt0LakogZA+AVEscO5nxcNvZivw0Js6Ko2SmCv
	 WXz3MnsabMlyPLfXxSQ4Yi2IA2HAJPnOJ22/LWqk=
Date: Thu, 26 Mar 2026 16:23:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 James Houghton <jthoughton@google.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin
 <kalyazin@amazon.com>, Oscar Salvador <osalvador@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/15]  mm, kvm: allow uffd support in guest_memfd
Message-Id: <20260326162342.b8178cb8940123324c1c9211@linux-foundation.org>
In-Reply-To: <20260306171815.3160826-1-rppt@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Mar 2026 19:18:00 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> These patches enable support for userfaultfd in guest_memfd.

Review of this series is very thin at this time so can I please ask
potential reviewers to spend some time with it?

To create additional time for review I have relocated this series to
the tail of the mm-unstable queue.  That probably means that movement
into the mm-stable branch and upstreaming will occur in the second week
of the upcoming (7.1-rc1) merge window.

Thanks.
