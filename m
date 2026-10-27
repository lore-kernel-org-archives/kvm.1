Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068958;
	b=di4TD/VVNwSkUkZ57chxBWTq/CEALfh5lh64H3mBPA7ulgmbqlleDR3Hi8IZVN8At836
	 bPZzuWKSK9YDkdYDMr5YgR/Mz2XNtC/ZhtANNarAAmew0lf7mhKRuSZxErTMCLa1yExRn
	 2pOtyodqldrSZc0KYALqqzyi3zcmN1ri3jSaUcx6IcW8KnaWHVgybLYmwUGpKwtdwNC8a
	 prkgDSrlxel6IJzq0DXj9S39t0be4o6xUrNmLXZxr3VQmtQdH6wpFeP0gYSQpJMoRwyDS
	 SfoUFhHzTjjMxsbs98ZLHcM35GH555wLp2x0TLPhpdYHj+fN2VDZZURPrYKGt7Zo2Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=tuNHB7bdL3g3O4ZNDcCND8Z4oUpufdKZQg+VDbqXaCJd2TF3dksH91rBfjK6M6AZowwe
	 5FM81WNGX2V/NSIjo4haC2lhIxBEx48MovuAsW8I/LK1jFphi4V2/p574OZbqy4tsNqFq
	 W4aOKFIkXWKt7mCHewlGBTRsX6ZOQKEYjcRSCrwNKezXz4d7XlkfD+4T1rRkE8hfzUtst
	 +T6TMb/OcL8TUW8GnAZ1Vpcjin6Mfwp0VzX8NurZoDFpki4UloBolKtcdkVGOdSYSJyCa
	 DhCi5W8+hO6odyxNHOHSAb9nzow2+ZLMtDcoFY8WSgHhM0RuYggeQueDynFvSIUE8Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4A606A321
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 02:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB4A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14fc585291cso1850459c88.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068957; x=1793673757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=nAMLJ4pov/UKnTCLgH305UyFiee1Kbb1n3tCzOl712VaepOkFQaBHOfe8TqG3p1lZU
         FcmqVqrrqUreTloBdzXh9C3S8RzvKdqK0Wdm3ymTtA2e7F8hg+g3tAXi0qMz5tjjKhfg
         XZsmI+gaR0xwl7nmIQiVOSWVXQuFdQ0nDSV/JTrdP8vh+zCmGEp4ByKhGzO7Q9EFAqG7
         Z9UxSRbzl1SyjYddPBfqeotnjUxiWUf5QMQHMI+2cHXwFS8e7Vcd6faApvoLAEI8hyVq
         H9p+0vB8HKXlTDO8gBcIdyEeUOqojMCpKudjjewsxrlbiMp0bSMq+X14CJGfZa/XuOHM
         djkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068957; x=1793673757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=pVxm0/asCXnA27T8eBmZc0H40BJufVMgEFud4L5JilzHCbOyQm4aZoccF6xdUbVG1a
         FPufVAZE387Zfm6WRSzKtEOd7XhS9/gnWD2Uh/P46l0yZQpfi9tXjJm2qOnZUF1hCcjc
         rZ2Yb7kh+kD2kYKBNW6nE6mS33fOr4k+bHTAFpyst/lgw1ZDjUL3TEci7tn0cGrsfdLr
         zljkTxoWKvKSMyFDSU3bwLbQtJWXm3G6Ggye3uK6Yto3a6fpbguyvoPrqK4pge02paP0
         5pMKrRdYA5I1tr/mIVV8LuvjE+LoBzHI1WlXeSIP3aooazcVizwAzCGuNrHhusriQ9p+
         SRtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi6RtqGKfda7JU5mk3C7bE8p2vP46T+pQInsJ7rvF6cR9P2736sEd1f+C5ZmW8PZdr4rg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFwEbNMTKgFdmYKm9h+W9tKaNDvjWgMoGi3iWb5J5aqXA+dbiN
	+NO9Rt9NucsyjANlCLIhivDRH/u0JiqdeetCAhEIonqIycBTwQLp7XSUjiUFjI5pWtg=
X-Gm-Gg: AYBFou1kkhcfSnxWd+kQSO0MiJOuSOq0S1aIaTOYIP/xOdJWscROXB9gGGiQjveGsU6
	h+ICccqfzvrN2VVl49y5FtrzSQxj/SrOxeXdT/+/OexwH22CB7lNESC+CMEzthnzBdqthjnNa0x
	YKswM+pZdVVXKs8QuGxhS1i4JhBvQRJmphtuYWaNiqQ9VtkWMPeNBbV8ZH2CIV7pxEit1/HpyM0
	6TZL3Nbp7k8XybU7C9i0vvkNt0OPy+0rLOACj48qxVJzoeOXVgXc+tqDY1F0Zg/csjbfBvintR5
	e7oXjnnvxSj1SSGGop9kmyG/Odj13r4Fqhs5KXT3RMiiUxW7apKxsDbwZp4iMp941INHMYLXO1z
	5nPy95ms94WOoIEaVRti311t9lsEYaB8MdzbpOnX4V0JRw3jQX60n043v2tw5D4MzZuZGTGt4RA
	Lht6qlH1aLLyCR73d/lbkQgCuMuyx1OlUcbTFK/ZHbO+RAwWuTgtruRruwsjOK47/R4bfAM4xdk
	cbHs6zG/aJ/SPLSJpmIEt+NiPJANTOwYbzfIDH2YQxKAyNbHSPheqGyb9VWiaWzPR+V14MF6Po6
	vC9rolqiplKYjp1lQu24VORjXowRC60AXHJVOls=
X-Received: by 2002:a05:701a:ca07:b0:144:fd7c:84fe with SMTP id a92af1059eb24-19937307669mr13761314c88.35.1793068957501;
        Mon, 26 Oct 2026 19:42:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm59514670c88.17.2026.10.26.19.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:42:36 -0700 (PDT)
Message-ID: <30b1cf28-61e6-4f28-8e28-79815bd87617@kernel.dk>
Date: Mon, 26 Oct 2026 20:42:35 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user
 memory when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-3-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

