Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F53876C3
	for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121706; cv=none; b=DuseiGZvwtz+iA2K7oSXlZ4mNVwtq1himSNr3b6QLBaq+ctfW3m3rL7MvAnKsS4zdaj2YrPbZa0voo96ONjvh/oRzIY+kSz/kW5NbN8PUgRAvaHsGvUy5uPjlruWPOqFV9ewor7bYXTvqfqZlLfabDH6GVOkmbP3ZqqEfBdlbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121706; c=relaxed/simple;
	bh=2K0GX3mzxxaY4fVt4pRaJHoMk00nh/g7bU3J/t8Ugrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGUzjMmbDBJ9yS0CEO5sSoCQ7riKVJWgyI+iNbq101s0yO6hrz8yEyyo4vi7HXIrguSE75w3SSWnVufW7ZB67jqpSNTjDKqOz00rxJ2nGKdgzW9NxBtaV5hdkP+hY8aiorMwUnhffZy9vbjwSN2we1qK+Tzp9FF3rLkxYatrbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCeydCik; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCeydCik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A95C116C6;
	Thu, 26 Feb 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121705;
	bh=2K0GX3mzxxaY4fVt4pRaJHoMk00nh/g7bU3J/t8Ugrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tCeydCikWsdtRb4a6tHttDgpN/c3VIrttFRCX97FHGNDgtQJGETdhwNPREQ0wgn5D
	 pNa9yXDrf8PNBiVXY125P49yA/61Vt+jVekDYYUUsEKvku4ApRiQvBEI18MfQb4hM/
	 ypFY9ErOT3oHjE0VpGX78f6oQfXFDw7sJ7irmb49J/sQ90aCm8/Wc6mLkCxJ7HTbGo
	 XzGDb1JJ8dKCNcfozKyaUITSRVFc+GJW7ziEyY2Qwrz8JI4SurjaptpjqSJ1ywotbw
	 JZZ/hWIpOfCxKJ/ghqWYOqINbQBAN9bLhAb1c3RAT1+L0koWb7/pailnV0B6XfXcAL
	 hIOyYdCmKfimA==
Message-ID: <99b0ab59-c1dc-4d23-addc-7bf4b87bfa03@kernel.org>
Date: Thu, 26 Feb 2026 17:01:40 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] system/ram-discard-manager: implement replay via
 is_populated iteration
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-10-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/26 14:59, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace the source-level replay wrappers with a new
> replay_by_populated_state() helper that iterates the section at
> min-granularity, calls is_populated() for each chunk, and aggregates
> consecutive chunks of the same state before invoking the callback.
> 
> This moves the iteration logic from individual sources into the manager,
> preparing for multi-source aggregation where the manager must combine
> state from multiple sources anyway.
> 
> The replay_populated/replay_discarded vtable entries in
> RamDiscardSourceClass are no longer called but remain in the interface
> for now; they will be removed in follow-up commits along with the
> now-dead source implementations.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Isn't it significantly more expensive for large guests to possibly
iterate in 4k granularity?

The nice thing about the old implementation was that we could just scan
a bitmap, that is ideally in 2M granularity.

-- 
Cheers,

David

