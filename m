Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50959283C9D;
	Wed,  6 May 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032835; cv=none; b=Cyv1np634aMQFiEog57ON+t8siIWAI226CsKWApbmdJ/ZlnnJbr5qJ91iGnlttLhurUf17eAqvt07NSJH8kkA4Ef3eNdsMR4xgLnIpHgjgrY9mMTAxuvnZ95xPLZKYONuOs5O/nfRFsxJkT0niDFFgnBworeuId+wtYZuiYg/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032835; c=relaxed/simple;
	bh=F+8Vlb9jurWZhguRxg5yIAVEgTP+P/vVFiPz8zVArMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS9Fw5ZuDfrTffYOeOk+OudkUOATBuKLMcecCNsRIeFxcFxkWf6nN06NM436RT9+VFfq6QNiw4SZpU8e3ZTsfD+On3bXgn25NKUZTEPnWS9ziOBzmJfgjQDhiRxsX0Mk5Uf5iSTXk8uCjk/m4VqZLD5ZpOnAm9yII/8MAwH9JA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESpsnSVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESpsnSVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2332C2BCB9;
	Wed,  6 May 2026 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032835;
	bh=F+8Vlb9jurWZhguRxg5yIAVEgTP+P/vVFiPz8zVArMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESpsnSVZITdLouN4BAmcwI3BOgZyi9tAF82vLn44Pzk0KOMfCgFdCYDMWsElFPqQR
	 XXpL8753EfROS6XNN9zQ4qC6oJZWS80y89u3mf0PVgqeBsJ4K6oieyWVxHpRO5DamB
	 F3Xm71ARKFm80MNxTyKpi4grwIo/zl9I9P0YeufPBcg4I/dHyjoGGmvOQpGI68N6V8
	 +mpsMcq3TKZyIWuUy3BVRf0rrGMNcNBgEb9BUfu/2jj72rZpq3qZAMrFAV82DhpXAY
	 bKmy44ZWDhJOzR+WqKmzexvw6G71KEHDhuD14wfgDpKAHYEPmXPFTGBITfXwZ3jTNa
	 Gc21LGuWk/hJw==
Date: Wed, 6 May 2026 02:00:33 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/16]
Message-ID: <afqgfvt6TeX2qVe4@google.com>
References: <20260506015733.1671124-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>

.. and of course I sent the cover letter without a proper subject. This
was supposed to be:

"KVM: x86/pmu: Add support for AMD Host-Only/Guest-Only bits"
