Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17269386572;
	Thu,  9 Jul 2026 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583735; cv=none; b=YcNMINk9oLL0783e12vMtMKICxv+b4l5reljLskj7iI8HkqRVmpcTrovXLzrFPajQ80vMZUWkw9ECPHnXJD8jgW+3WrYrHgWz9poREcJtl1etYLBiigQJs7j+peaVV3VIfXgZAKqxLR5QsUSJtlic26aF7f8GZWGJGVNtwEyuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583735; c=relaxed/simple;
	bh=Ymj1+higkpwjb1VF/3tetoAt1l8TqP3cQCKLQsqnTnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhIEQNpY6boG9JiSW+jmZ8ifDbaoLmcW6rnkFUYuIHiveXpb39bV+vzJ3+2GGjJNjojBm2LnZkl8OruWDk9fFs3SHxRP/SArIV9YPmboOxxBP9aaMvw8sM/myRbdxRuvkgD3UJPCoQq4SVeXmO0gd29pp8L7NRy2Y2Sp6CpHMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUpGjVAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUpGjVAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71671F000E9;
	Thu,  9 Jul 2026 07:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583733;
	bh=tQr5EKbGqBU7SqYZBqewZ3ATW9dV1SlKrbwDR2ZWZwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LUpGjVAZo1MO8zeFG/Z6IYMu8YuW/ginCOWmKNGImLm8Th2LIGmXx6RrDftL6sNdu
	 heJCOhuSXdsPtomgakgVce2LevH8ufk3xANbNhHpGuf1/ybU9ylp2NI+3asTfFxM6C
	 H9H8AD8K8TEPLuvIMgq6zFHJeExBWdk8x8E+15P1WCf//qeh+zG5Lg98l8N72htt7t
	 EKzpKupmZll1CQ06ykYOpbFtZBEf/WI28jojp0pZsFRsC9Fk8d9PyAJXlTLTVEbtAk
	 42+7lyc/DoSwrbcMOHXW1A0VKmMXPaEi3t4d/qSvmkKMq81NeXdRrIAo1LtN/r/Pdx
	 aMZUvqrnvCGKA==
Date: Thu, 9 Jul 2026 10:55:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, peterx@redhat.com,
	david@kernel.org, ljs@kernel.org, surenb@google.com,
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com,
	corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com,
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com,
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com, kas@kernel.org
Subject: Re: [PATCH v10 14/15] selftests/mm: add userfaultfd RWP tests
Message-ID: <ak9T7boe4-5YAsFX@kernel.org>
References: <20260708111417.173443-1-kirill@shutemov.name>
 <20260708111417.173443-15-kirill@shutemov.name>
 <20260708225758.0c8bcf16598f82d84ea7f71f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708225758.0c8bcf16598f82d84ea7f71f@linux-foundation.org>

On Wed, Jul 08, 2026 at 10:57:58PM -0700, Andrew Morton wrote:
> On Wed,  8 Jul 2026 12:14:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > Coverage for UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT:
> 
> I'm getting selftests build errors:
> 
> uffd-unit-tests.c: In function ‘uffd_register_rwp’:
> uffd-unit-tests.c:624:25: error: ‘UFFDIO_REGISTER_MODE_RWP’ undeclared (first use in this function); did you mean ‘UFFDIO_REGISTER_MODE_WP’?
>   624 |                 .mode = UFFDIO_REGISTER_MODE_RWP,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                         UFFDIO_REGISTER_MODE_WP
> uffd-unit-tests.c:624:25: note: each undeclared identifier is reported only once
> 
> <etc>
> 
> Seems that tools/include/uapi/linux/userfaultfd.h needs updates from
> include/uapi/linux/userfaultfd.h?

Hmm, I wonder if it should be there at all :/

I thought userfaultfd.h is brought into selftests by make install_headers
  
> I'll disable this patch for now.

-- 
Sincerely yours,
Mike.
