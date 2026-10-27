Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068885;
	b=Deypg7aTs2MQtT3ls07P0kGJsclLqUUwu8CZDlzV4v0VvCMMv1pGMzs0ISpe2CIl2UJl
	 mj/wEwlHwCiCrFyJsYMjf9c5M8aUnGRcyNp+/jICTGEnxWDhL2KXL/rkRqsE7mJ9VWjVq
	 vcHnBom/EzcGik2S8FCJbZxOiayzCyliufDkeXOAOxUFyGYMVtNd45fdOD0LSfh8oIjUC
	 2xci/HFjgW+7cJU5vRXgqmWoiZM1k58iNvA9w2GTwvBZx+EYu7v1sC2iuzBdPHYHUd8aA
	 vIVEcIFEYULplF8v6zY1vTFQVNnLjm04Rsb+lq78Fiw/p5+Tlen+EyEadXw8LU4X9qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=qYn9C2G6rabhH4cfFDsOfYbteSgzZLI+79tlmZjo7U3mV1d0OGqZPoTpu5LG9M5QO4Om
	 wzVuEt2myXV4BFgBrbnGMP7wLGUme42zhJo/pGeCq4++M6+OzuXIO9kk/5rgRdW8jyA+2
	 bgRvKCLtVJBsrxc2t8++BpWeL63PCBkYlA6PIsm35wu/sWmTC9AlLu0RpVJqBRacKd0fF
	 mF8ibItR44CBvMpRkWYEfyKB5WyXYWFKq5o2P2iJ8oFy78YtilIvNFaQJZeMVGLfB5nva
	 EEhFEjs84mDxJKFF8hndvegRUmVmo5d1lkSc6yhCJ5Mz+kxq1HdCj93qUcsFjoe0RBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oc6cZqFa;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C06606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 02:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11C06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oc6cZqFa
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18cdcfc05ffso4488336c88.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068884; x=1793673684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=oc6cZqFau/HqROtNMBTq8ZP3TLLLzMKPOdbVxFYEww/DOpOMHzAfKhTORNvN4KTBkp
         LUp5Moi9eFCEYu5/4XDZT8WcjpiPsCN+0zUGPUekQp2yZJY0zBe8yl4kYAkKqjEdTrbQ
         qqNSykJeEwW7qBFZEoQS1rQ+7ZwY381+e8TxKyiv+Q5rLJiCFF4PtyVkTxWHTKQMc6vO
         +lb3qFo71UgGSSnv6IseZ7y8wLhEFz6jBXh4HUpywe8jgXN4FoqKQy7CyAzCO9Yfeytz
         HBIYtHcP3MQ7eijYy79F5eSeZqsN4/+XnIDB6Cna6QVY5R0NQaf50jlOwAuklcgL/mVV
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068884; x=1793673684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=hiou+Csqmmhjt1l71juWxXm3wlaPnHcWniTr7fzKTz4CO0xNO2GOEIgLfmf5Vcur2O
         B/HJnLSUuNHeuwQRj3DAstrGTfKcPAtWqJvncB3BDsKoD6E411bJseryjxdeEg8C+B58
         3Qb2vOCCpZvoBVS216rUvYsFYyjgMEgUpZIAnV6+ZooMM2K+jNOWedkaU0QOgw34sEpZ
         j9yH58cv8CIdxzbQ2givf7D2pOK5/jIqHnq4+AcQMGqKe4ZsJbvFUgnVsNP8P6WAfXtR
         xoUzp53qytYc9CBCY0QrH0oIECH6lRXFliKITGUbjYO+o3q3R5z2/5UpNZ4DpDCTOHWu
         9q1Q==
X-Forwarded-Encrypted: i=1; AKwUvByd+hRq7BI9aEhX5nTSInMtamB6/J7clp6k3BalscuIGIIAwvtFr2JEz1yrjUQ2SiErwGc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkmaSd+LgcnjV5Buj7Hl0TdeU7qxmyebs/+HITcBE8quM9EVnx
	U+4jNKjQt+NsaEdqoCDvuPo+IijkBsPzIjQaRpy7ACmLsPz3atdsTLdUVtJ0AJAp/Cw=
X-Gm-Gg: AYBFou0ICJKHoqQa6ZHwGhXlDbe0fA+Z8NOyHCfqYq6VXUuuXtHgl+j/IFmifIx02N8
	O0b9uZ64wlq7cOxye3y3Dx4ceRTPyMxP/erjbZTEL8IhT1eG8AXIYNCTyOuNGmqICdS9HI17ypa
	7eWWAgvTPO14NPYgUO+SErKzF96+rqnuTinXlNPo4VLvZZ9BakTCp54x/8ZMQKUxjkjiJ/i0p2v
	RZ1iHXr1h4zPAJtQ1SkXzGfvRrCLkoWGP2bbVAfqnRukBzthkBQstsB8U+RetVq5pmhJbmUu3b3
	N4968nNB41zOTQPhwcVfAOLmympwc8GMg3nZkU3jGQsnFaTE7FTpJkXWzrVDkN2469RjIGfrYiy
	GfakL4+FYXHX2MAUaCom+EttWJqaVdkm88dBWct5+5DvtMC7VF2AoshSEmEtTVuZtgt9GaAkxN4
	d/8t22f7hkSG8UEwScIVWhS/37zCV4CMNtL99LQR5Vp6nvZF25+1M8fH13BH1hQ99bpM9GgUtkG
	19/dmRR3rl/4d0IiZHjnGh4dQ9xFHEU3QgOd8oCLTQm4g3F1K+5gokBDy4wgTNnsb6sbFJrDg2i
	tNlsG1rpJ5a44zYu9PNGlunLvFjwGNGRKQ8CT7I=
X-Received: by 2002:a05:701b:4184:20b0:191:444:425 with SMTP id a92af1059eb24-199290fe40cmr12440066c88.2.1793068884148;
        Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm29293759c88.14.2026.10.26.19.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:41:23 -0700 (PDT)
Message-ID: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
Date: Mon, 26 Oct 2026 20:41:21 -0600
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
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
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
 <20261026215226.3713941-2-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-2-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

