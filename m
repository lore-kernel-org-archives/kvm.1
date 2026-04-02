Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C63612F3;
	Thu,  2 Apr 2026 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775104546; cv=none; b=lwOPnoHg1QpHcX4SjNODd1TTYDKesaUvFPrdyfqzUTO+vLp6GWnhva0ZU5doaMc2TKvCmDftH8dUOJnGxgChC+Q/0coohZN2rMzxlY10H2dq0UM3psv5SENdagJbdKWf5MuqxX76q5Ey7hB8DBmeHJlU7kL8O2p+mPNqCSsWmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775104546; c=relaxed/simple;
	bh=dyZDLpwSsmiWGdb3XAQ9uOEMQCQcXcrQwT6RziiKjgY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XMcg0YfJ0eKfiO4bjTmIcDdQbT/4eoYjt2MZXtQVmbeY//63e9lvt1MCwhW9CXpK1gwiw0gSmA+hmy1IWt2rNjdW7IQ/PcBSyPowkw5zmtcXmK8hR58Sl8PJm6w/Z7KuuAK5Y6J0RgK0q7pgLdW2FPsFGuRb/p1PjRjwAwNlWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MsBLavZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MsBLavZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDF6C19423;
	Thu,  2 Apr 2026 04:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775104545;
	bh=dyZDLpwSsmiWGdb3XAQ9uOEMQCQcXcrQwT6RziiKjgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsBLavZGgHjshyBlG8mt6tKnxV58eRjuTojZ1d8BmLYcH1n3CvEag5AO02cMVTNiG
	 qrcmaaQURV3BbbqlFFOkv7nHrtoDI0hT2GX4WND/7w9xvKnHAqiXW7ISCywcrPMXHy
	 DzL2TZIUEBg/JDaTU3QbfSNO2UI7qhc3xxPLijIM=
Date: Wed, 1 Apr 2026 21:35:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin
 <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, James
 Houghton <jthoughton@google.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin
 <kalyazin@amazon.com>, Oscar Salvador <osalvador@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 00/15] mm, kvm: allow uffd support in guest_memfd
Message-Id: <20260401213544.fe69a9a20e0ab052c8fa8b24@linux-foundation.org>
In-Reply-To: <20260402041156.1377214-1-rppt@kernel.org>
References: <20260402041156.1377214-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 07:11:41 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> These patches enable support for userfaultfd in guest_memfd.

Thanks, I updated mm.git to this version.

> v4 changes:
> * fix lock leak not only in patch 4, but also in patch 2, thanks Harry

And....  this resulted in no overall alteration to mm.git, which broke
my very surprised script!

iirc, this series was to fix a little bisection hole, so this is to be
expected?

