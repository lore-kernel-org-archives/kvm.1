Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870A49E5D3
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290235; cv=none; b=KAIvJ1OYf1+2E4PLJFWSPKde6StlqhIlEKkfkHWBFAe7FlEtJb+t8tnJ/333jQks3S+rAXpQWH+YITHN1Ne2BlSAVyl8S/vwsHrfIJoZ41mE07CnNenYWglSodgb4a6S9QOItv/k1cFxvl7zDo2DXFHPQf09ysTF5gJEUlPW+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290235; c=relaxed/simple;
	bh=ok65wtnLh4/jf/TJcVJdkooFgQY/8blBctwC4Sx2UJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Dmv+r6yN6vvmhyDGXnHQRaCwowAXGDV0HYwohKcTrB28SRJrPCuVQ0E5ynPIufzZeHuu6Ae6xs5jxWAH4UPnXjHG2l2NWB1v0Ok1lS5vH47OHkEN4Jf8pfHJ2tyw/8Ow4RvFklw3OoAaTDjumiCKmFok8AkTCx0HJt8/kRKIPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kB9CuOo5; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB9CuOo5"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f75c1219so2531505ad.3
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788290233; x=1788895033; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmO9NVIPso6yFfzV773x3a73vitmuuvzVf1ZmBlYCbI=;
        b=kB9CuOo5ecJ7P7jbeF1t0zxSZcnFX0i7x1X4KVDa5oNrJJUhEO5A9/IYoVqVQXCXsn
         loVXAI1c3XFVPvvNo8YfIQJj8J3XvIMgv3U/YxDeQgJGI60tlaRLKPSXZKbKEWwcIyrt
         iBHgXaGiaCbAkRqcDoPwLvRKqPO1pK8nvNDRxBAri818qTvW9qWs49MoV6OUu2Kdhfg7
         daqCs8Rn02GDWURytXzDinEUZnDrgDDaiYrnrP/4jGdcRZw0YCOxBgyxgA/M3y4cG8r6
         AihA3Rxj/SCK2iYFSMYzVqrZxLyy4perVceOcYanMzX8dNrK/JmiIeUUN0xCj0h7PzDa
         9jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290233; x=1788895033;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmO9NVIPso6yFfzV773x3a73vitmuuvzVf1ZmBlYCbI=;
        b=evP/hwCnsgNUfHCAl+5mm2CPu9IBJfQj4fchc/ppeoLr3GQYWxLs4vb+ydc/OO7gnJ
         U5QqkgIZ5EFobbHndjZWlLWd4K4m8TIsSnYQ3p25KfHcO4OgVfv6bqPIqoyK4ogQmd6X
         MK9LvR64X84YqVdkyJEaMNzJwmcfOofmFKSE39/l6MDherM9T/86mv79w3BpKxAwpkWG
         cvl3C0OSY8tOYrjsMoAlx5jerjozo7u6ffcpazE4OPBBBXAZaaazaeZyQJuzurR33WBZ
         n8JOovlwjk1txT5TXY29HwDjM8Hrc8y1Da8A8Z4Frt2RDXuIhFf6WYH8XeZqGvUcu0f+
         9llA==
X-Forwarded-Encrypted: i=1; AKwUvBxeZOs6tSo1u0puhTHTv5vyXcoOqEMGoFeYS4kb4zdh5XXVn1EG1z+NU2mqMKRtr1lGmH0=@vger.kernel.org
X-Gm-Message-State: AFuF++ko+RFRyul00Uso+yiseThL0aynmF+ctO/Dxi6PgqZ2Ju1fu7d9
	dXriZpgP2WGyK7oEHh+iDps5SWFJ5PN0kMOZCDITbUzidJkzbFuo5yTJlXUI8ACRuMbmJodYwXV
	NyxQmsg==
X-Received: from plpo1.prod.google.com ([2002:a17:903:3e01:b0:2d9:17d4:914d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffce:b0:2d8:d4d2:dc9a
 with SMTP id d9443c01a7336-2d8d4d2dfadmr412111075ad.22.1788290232898; Tue, 01
 Sep 2026 12:17:12 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:17:12 -0700
In-Reply-To: <20260826213303.914988-22-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com> <20260826213303.914988-22-seanjc@google.com>
Message-ID: <apckuCeNCfLoYe9R@google.com>
Subject: Re: [PATCH v10 21/21] KVM: x86: Use kernel timekeeping snapshot to
 get walltime+TSC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, Sean Christopherson wrote:
> Replace the KVM-private vgettsc()+/do_do_realtime() timekeeping
> reimplementation with calls to the recently crafted, generic
> ktime_get_snapshot_id() interface.  As noted previously, the snapshot
> provides both the system time and the raw_cycles (TSC), atomically paired
> using a sequence counter.
> 
> With great pleasure, delete the now unused read_tsc() and vgettsc()
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> [sean: separate from other conversions, express joy at vgettsc()'s demise]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Note to self, this needs to be fixed up so that David is the Author.  I'll check
the other patches too, I suspect I forgot to specify --author when splitting the
original patch into 3.
