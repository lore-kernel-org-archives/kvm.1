Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DB1ACEDE;
	Thu, 26 Mar 2026 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774486208; cv=none; b=OL9wQ/NRjLnxRwgjZKWFZ5J2Mj1zhFfXDl6HAwufthlb7bgT6+eTDxPjVnWO86tnNdQcwtGcmIZQ9zp7gVxm07KdYlYCBXAQLTn/67Cl77PyuIaiCYr2nOyVzRKP/rwnuuTRau+7X7LW2zmMkWRR5wOr10CmYZd2sSL5yAXT9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774486208; c=relaxed/simple;
	bh=+OmHiraGimH70ANOJHEaNBOgGdEAVeQc/N+5UwHJRrI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mYByW8hZJw6f9POgDvv1aqzh/qF/3JiE/rNohcp9r0hAUJzUBY0Cf6oAPw/0x8ImPafLhyCzjKeCahJSAWo+W4qARfoG4n1U4SQSe/9Kzx1j6WotQYcubwgo8hS+l8jlGXtavkv3HAdtwTdyyVHgON73TYZHoQk/kLziniUGmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qLYHKKHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qLYHKKHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C45C4CEF7;
	Thu, 26 Mar 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774486207;
	bh=+OmHiraGimH70ANOJHEaNBOgGdEAVeQc/N+5UwHJRrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qLYHKKHR6Wr/lquOKS2e/gEJJlRCj2LkxHzXE+VSA+b9vcX1sBFN+VhGUIbbS1B0E
	 pfNWOqg44Q/rEv1fsm5GOq7oSiOvKM8kosWkN/RoJ99g03Jlxz+oObUNh/sNR1qV3W
	 5UStY24RY7/E/KZtqBsl2tV7uepJcm/67JlG4Wto=
Date: Wed, 25 Mar 2026 17:50:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mboone@akamai.com
Cc: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/pagewalk: fix race between concurrent split and
 refault
Message-Id: <20260325175006.1c3cae2ee50dd491a153226e@linux-foundation.org>
In-Reply-To: <20260325-pagewalk-check-pmd-refault-v2-1-707bff33bc60@akamai.com>
References: <20260325-pagewalk-check-pmd-refault-v2-1-707bff33bc60@akamai.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 10:59:16 +0100 Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org> wrote:

> The splitting of a PUD entry in walk_pud_range() can race with
> a concurrent thread refaulting the PUD leaf entry causing it to
> try walking a PMD range that has disappeared.
> 
> An example and reproduction of this is to try reading numa_maps of
> a process while VFIO-PCI is setting up DMA (specifically the
> vfio_pin_pages_remote call) on a large BAR for that process.
> 
> This will trigger a kernel BUG:
> vfio-pci 0000:03:00.0: enabling device (0000 -> 0002)
> BUG: unable to handle page fault for address: ffffa23980000000
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI

Thanks, updated.

AI review has a couple of questions:
	https://sashiko.dev/#/patchset/20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3%40akamai.com

It flagged the same things against the v1 patch - maybe nobody checked?

