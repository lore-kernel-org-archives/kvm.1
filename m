Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB43C6A2B
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041653; cv=none; b=eWHOa9JYoCb/j4bsKZ/dgbGNW87pc3bE7pDFB7PVhNf4ydVfZv6mKjKWhLnGVV5nTrnBRYflDbU5gf8EfWDXDBq3G1QxJSkt6RmnqtRCpe62oF2Nxy9gfA8tDYx/MOR/ug7lPTJ8V28fnpYaIzZNb8CltMcm8n1KYN/V3n1J7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041653; c=relaxed/simple;
	bh=ssQXKcLcGAYDJ+MlHe6P5SXi6S6dHklut16i873xFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdDxtoFK8vtmWKTDPxwOgxBAFMt56zBw7TF/CTb9dOXINDVj/l+2gKp+S7IOPxyG6xeEye2/JeQ11jKfSibvU/Q7BuXuAY//yG6Hz3msddz9D86vLRqNM4m0B0FZRe7jHYF9hNNOhOpO5a3HyWwx2X9/GCaZvj/5caO3e3TKRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kyY1MOez; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kyY1MOez"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651bf695701so6434607d50.2
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777041651; x=1777646451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MGeb+YYn7RN3axNi7qPpfKeHmTAGHGlAbe1TFBeXhXU=;
        b=kyY1MOezylA79zBtj3kmcMYQHCmr4SI/htchkVaO2N7heXb4aSObb7WLGcZ8SfZMsV
         w//K8oEwFKmdrPlxQg/pJzYfTTMMTLPsUP56eLpDR3XydP11WnZog6MNvk0P8wdMqoR1
         fhiVhm/8bTXnpWP2X+TBy74OBsR4No92mGslWdV0enTf9i1cKleYrUlV649Hlv6KARCd
         vqvKaqYfTqZ6PAXsyD/hp7fLTu4XTS3Cay3STKyO0HZyKCWNBtWixuuLCP0IXgXE8Zaz
         BDm6rZtr2o1Q4OJMCw6sXX573tzBNDFIPoReq3qQ+BU157F0VykwFgJCPMkRkRnUPkJI
         +tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041651; x=1777646451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGeb+YYn7RN3axNi7qPpfKeHmTAGHGlAbe1TFBeXhXU=;
        b=MBQQ9cuyCG2fut2ys3JKF53IL/MTBFHzD+MduwJLknY49Q81DOmy77z2H6SDvFEE6p
         xlj1RoAXhTU7jE/JvSyTgJjIFX28hRr6haV8Yxuak4HaePDkaAiraoWLD7uy8nSpbC0r
         e7KE2t1WeeP+rTjcJK/X0cSkNG5ci75xHs/+OrtzDQ9zm5cm140+qAUS3yKjQmko3uBY
         ex1nLrmSKUfbOGLGF9QmifNmZlweBhsNDPqcH2bEIfzIudz9flEJvicoOWwj8UQXGHfA
         x/et31RperogHchpcjaBOun0preH7WRUU3uvea5L9B2M+ljLsmmizq0lnafYr/4u1PUo
         BBiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HAF2vIokPTYj7htgG9YCzN9LqKlex5viPZBAxl2fBqaifLlngrpn16bP5vMmiuPsaK3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlREOhjCgz86nHqRfmpJ5jgS7Af7ev3fgaJx5iINSV0AE0Y2X
	XV/C7iumzdSwef0UY/e600V1kfmseSskBa9SyAd+bIYF5+ApI4c+MoAR2mwte3I1ARg=
X-Gm-Gg: AeBDiesMh0xZG3jXLfgtnf5Xex4N4pu+MSfXfzlPRh0lZGuWkhkdBxah7gC+OFNNByG
	4sy5H79fhS59yaZK1nsNdeEpChfRnAP/k8G9oKtv0XrUwBpNQNhooEI5ASgfyn40ekiuP7PP20m
	dp2Nv5ClEWOk8io/bwmNdmvpcy6P01PYyEPsDn0BftU8o7hHssQh/MQe2kXcW+hUMsHyTppmBnk
	7MNTvhI51rzndwer7Qf/8sCi9go0QRK3CeTv15pjLMj71tZmjQGRWZy4dJ+/nltcy55Q4afoeBT
	DOygu/Qmmdxp/LnMoA2TzNMBtD9TeHyPBG26mX1CQ2Ld6wpcsXrljya/d/HBglt1VJNQ2uDZKHZ
	jyPEOfAoVffb74QvLSF7q7JoEvO2iBDQTfp2jSVFv6O36cCJCVl3EO7obkAXWkw42zStbdwGDfB
	dkLqSAd4TDdsrfLV8TcNxZ7W4y0evxwLiSfWcdKYbA6JPDQ3d9/62476kf5Px/ZNqtWO7WUck6L
	ZlCiVNwgRlRGMI3dwip9OVqls+SaSG511Cr4cPE
X-Received: by 2002:a05:690e:4004:b0:657:4568:c4c4 with SMTP id 956f58d0204a3-6574568c682mr1080804d50.18.1777041650771;
        Fri, 24 Apr 2026 07:40:50 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b25fa8sm10692424d50.1.2026.04.24.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:40:50 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:40:49 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, ypodemsk@redhat.com, 
	hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, jannh@google.com, 
	jgross@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	boris.ostrovsky@oracle.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <aeuAwkNsmDer08MD@google.com>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>

On 04-24 07:31, Andrew Morton wrote:
> On Fri, 24 Apr 2026 16:20:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
> > On 4/24/26 16:15, Andrew Morton wrote:
> > > On Fri, 24 Apr 2026 13:37:04 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > 
> > >> On 04-24 06:30, Andrew Morton wrote:
> > >>>
> > >>>
> > >>> Sashiko questions:
> > >>> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> > >>>
> > >>> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> > >>> said the same stuff about v9 and it's all wrong.  But better safe than
> > >>> sorry!)
> > >>
> > >> These emails are helpful; but, I do not believe you should have to 
> > >> manually follow up with a link to every new patch series.
> > >>
> > >> Perhaps  Sashiko could automatically send a summary email in response to 
> > >> the cover letter, or provide a link once the reviews are complete. For 
> > >> the kexec ML, we opted-in with Roman to receive automated emails from 
> > >> sashiko.
> > > 
> > > Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't like
> > > that.
> > > 
> > > An alternative I've discussed with Roman is an automated
> > > reply-to-author with a cc to a dedicated list (we could use mm-commits
> > > for now).
> > > 
> > > Preferences?
> > 
> > Reply-to-author would likely be better as a first step.
> 
> Why do you think so?
> 
> Pasha, is it too early to determine how reply-to-all is working out for
> kexec?

It is too early, we have opted-in only at the end of last week.

Pasha
