Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA325B088;
	Thu, 17 Sep 2026 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689431; cv=none; b=XKwkdpZTYgtBAyCOIPGY8lHEOjxcj9fCZEqr7TtjFfZruYKg0lgAcgTYaAS91bu67EuLqEqckAcUZZRxf8qKOzrPA5kjprFOTE/H2gBgCzTrSrMcVXXVfn6+t9t0u93j+Cxnrczf+yB7kJjwZ01A0jihZixEocWLKJ6ak6wplOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689431; c=relaxed/simple;
	bh=gw3INg6uIfC1G6EKWoZ/02FnyzQwz2sZoOsL+WCKyG0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UskwUPLkWfY/LT+yqD0bpbE11PgIahRWku7kON7mJetZUaOE5XBf9wFCa46iYGWp3YO0wWyZWfG7z0miPUVd37Qu77/KUPe/oh2KAO+Vg58KCw0WbLZMaT/uWgOPGm7cxZoB4snY9W1pcemwZyw3lNtP4njbGiBCbo4iyYVWpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M41eWb1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M41eWb1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6461F000FF;
	Thu, 17 Sep 2026 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789689430;
	bh=okDvTsO6fMQp5UAsrpdoSDKyHL/mxyvqlyiV5FJOiJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M41eWb1Aamc30Pu9mvZdY4CNShDDW5roFqOaWSyyS4sL1qEuksxPjyYFFmigSOsbg
	 ITwKrF9vU6YvlgyMOJxgZdeu4w+pkTCH7LPWY716hVQhlbzPxA+WJJTUSfJEUjGnHc
	 K/i58BTWTIfAaS26v0pvxgty4iCU/ynPraxtxBwU=
Date: Thu, 17 Sep 2026 16:57:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lisa Wang <wyihan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Hidehiro
 Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, Yu
 Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, rientjes@google.com,
 seanjc@google.com, ackerleytng@google.com, vannapurve@google.com,
 michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com,
 dave.hansen@linux.intel.com, Isaku Yamahata <isaku.yamahata@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v6 0/5] mm: Fix MF_DELAYED handling on memory failure
Message-Id: <20260917165708.0ffa717945e3e81dc7c25544@linux-foundation.org>
In-Reply-To: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
References: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 20:43:46 +0000 Lisa Wang <wyihan@google.com> wrote:

> Here's a sixth revision to fix MF_DELAYED handling on memory failure.

Thanks.  Yourself and your reviewers.

I've added this to mm.git's mm-new branch.  If it doesn't break
horribly then after a few days I'll move it into the mm-unstable
branch, from where it will be pulled in linux-next.

All being well, a few weeks from now I'll move it into mm.git's
non-rebasing mm-stable branch.  mm-stable is where we assemble material
for upstreaming in the upcoming mainline merge window.


