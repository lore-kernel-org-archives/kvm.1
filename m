Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692C44780B
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544824; cv=none; b=EfG9680eKcetyZfvO5mgUYyUAtBvV7fU83INY0r87xhh+2qJ4ITLisNCIW5pCTlxTcIHVybOsqgF+0aqSn68dDUpf/n83qWEv1UufoIyJHDg2GF6YJau1kleVGsupaeq36hSwMfC8hl2k0JXIM7oghwXuCfRE1iNLMmr7Jyla+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544824; c=relaxed/simple;
	bh=WlxY3wKIIciSK5xxJfmy8JG1Ui2W6Ke5GnD2nFInhFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfRJ73t5eh9uPE0smUgI4g5xXwOzBycwWeN6VRJNnG/9/g2AAxHQxC4iBpxOoI3v+m2BH0oVNx2EGk7eDaCrhfuZ1AQ+AEm2cZP4kRXYrOVGcIYYTu4xZyqQONxurUK6zyNut1KkTEa1Myf4MhWuuEnuTEIMZJhbyEb+rErXb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kgHN6hEi; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kgHN6hEi"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f186025973so9993546d6.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786544821; x=1787149621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WlxY3wKIIciSK5xxJfmy8JG1Ui2W6Ke5GnD2nFInhFM=;
        b=kgHN6hEi+OVMsAnhBh1YzI00xhtcCPzF06j9MhfA9vRGC4i59xCfvtljGURH2Q5PRR
         w6chLPersmDoxLp9VxCc2fERTxWdPAlUiw+62nL1DVUVtfZ8ZepWhdKcnbF3ckHc+eWx
         k1FvRCfGul3F6a0SWGhioNMzc8usfFoAuaKNUaoQqYU6cuP8pYBiQHs12hxuuw2K3TU/
         I7B6tSsUCwizdI4r6sL8MaHXxp/NXaMXqHxMlrfRvtKmKXcroQsqbimfQvk59+d8KJ/i
         YaGK+M+fHOSqlM4jAHCfQZb+V9pc5XGJfteqz5HyKVtyLUepvrcg+9kPQFvuAbk1kT8J
         PBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544821; x=1787149621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlxY3wKIIciSK5xxJfmy8JG1Ui2W6Ke5GnD2nFInhFM=;
        b=CC5PuIlozpFpLAOfBOngO0EMyi6ut5NBWnCDHNQLpMzu13IFNITfzgYvLtfKrVAf6Q
         HL2t1vF+ATmqHToPjYBnVxFm/kmlwSIZtX6///aKbS6jXX4cn791RhSGbhryMN/PI/fg
         CGxjLP+/jP8+zdGzs7KsHpYqW2hMa0QPGsUNfEpcV5TvvXrdq829f7+x0M3bmdEYY8i3
         eLUIP/e8BYouOB+5U/QLJm5Q0rRSDcI7DaJZ1HPXPz/mm00XWO7hVMrhVRq8gChVj3qP
         t5Q/5wBYEIeOLKM6nJG146bv8mEbVqDH6IllNLe3FwuZnpqWaxO0r6hL2yhjvSEZvYUX
         e6yw==
X-Forwarded-Encrypted: i=1; AHgh+RqiF31v61FfBlywwFY5efts2MK15BXHF7I2S86sjvqp2MYoybj0wPoUMFNXoK86Ghs3fuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEYmR6jVwh4q82mULMBpniS8dSpFO+wZIjpcyANfVPCc4KMw0
	H60dHWGJn80QtxVcjAiR6qPszu8ddw7XondLHRGAF7HX3T4nJW7QLXX8PmmrfvjRIrw=
X-Gm-Gg: AR+sD11OA/yupzE2TfmSCoMvnRs4UfjJ8g7Jyr3c19/CeaFCX1KyRPspu2ASXamSQ2N
	nQatuFu5+gXZej0YBqjgPnoWzcm7O+Xh+Q6/glrygILD3oTlzdJLNN7cSrZX972LifaTRifHnlM
	YBrOdFAjARqsOV+5D/sQDq/21fWuUiKD1CFSaIHzlnqEn4CEDmgxx3dcBvoFkslskRLEjotxZcC
	mrUsM+nc/G8praWWKtHiqDVgHmzn1mM2TZeuQ/Skmdo5O5Pk+P1kWFo8z5HK81+JjyrudiTjeUE
	T1l8/j4JpZ8yUZcyrbM0ln7Q88YSpk9EPMItQzwOuzs5elU4GBE/cUfTnz5z0IkhJqDpAwr4uqH
	iUE/lGkFie7KWdEVrTQX08nIDBgYVpJAuK7WkLxPX1SqSueeUiIwoxOrEWbfkPrZDcMA2i5896f
	f9kNFhdRtxjHPR5WMH/d2oafO+lZW84RayJWWuDZaW8zY=
X-Received: by 2002:a05:622a:1349:b0:527:809c:f9cf with SMTP id d75a77b69052e-52d647ed01dmr43708531cf.21.1786544821147;
        Wed, 12 Aug 2026 07:27:01 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61c08e92sm19033711cf.1.2026.08.12.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:27:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu9v1-000000036gU-37I5;
	Wed, 12 Aug 2026 11:26:59 -0300
Date: Wed, 12 Aug 2026 11:26:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260812142659.GD662699@ziepe.ca>
References: <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>

On Wed, Aug 12, 2026 at 03:05:43PM +0100, David Woodhouse wrote:
> the non_block_{start,end} guards around the MMU notifiers, which are
> basically never being called anyway and don't actually seem to protect
> against any real bugs.

If you think this blocked stuff is dead code then lets remove it, but
I'm pretty sure it is called and I remember seeing bug reports about
it being triggered in the wild. Vetter certainly added it because
their tests were actually triggering and they had bugs in their DRM
stack directly connected to this.

It might not trigger for your hypervisor case but we aren't here just
to make only kvm work now are we?

Jason
