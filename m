Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278C34AB1F
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865839; cv=none; b=KX4E0+rruq4PcdJQFA3oY299nYBz0bmUiOjq5QzJVBCjnvOVY3Y+ShH2U3YbIv/WyFVpqoBvugQpOi4cp0IcmI62GbYvntsE+IPl34+2PAq7vtphz1S/QKVdceS4oT9Or/h8JRMZMGbrBkHhY2jalu4pEpB4cJsGmnTNmY2YRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865839; c=relaxed/simple;
	bh=0Jvlq/8XR0iEgXTWN8DAOYkXN9axIafX6Am6mw6mKXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuc1X2VEESweLvFmnexqhMdib61CcHk6fL5WP8Sa8rbIKim+lZTnsCVkIObWteJ439EiqDAi/C/ylSH1YumOynIn+pt0G94cZddRSCZjc0Z/aosBNCCHRCQ6FbiSU5SnZCU0fmFwVL7XADTEM3zabFyK0S4rd/xVcGVIP+LBIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cGOBygZl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cGOBygZl"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad617d5b80so1375945ad.1
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773865837; x=1774470637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ChN7tMYzceoBm3vKkl8w+3T0ks+P2wQ4DzqmsgtL3s=;
        b=cGOBygZl/dzNzWZVgdxNWSJvVYsQnUbokia7V/AtGR91gn91RtrbfR8SjI1ub98L5N
         CGgqE2WyKUafcGkD0pwVjbe8wxemVXCeVjSAEEKY4y/4CYACuFs3/Ldgb1BpOjDHq5PK
         VMwXXtexLMcmRsS13WzS3M9P2S3EB2WZEC91o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773865837; x=1774470637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ChN7tMYzceoBm3vKkl8w+3T0ks+P2wQ4DzqmsgtL3s=;
        b=MXMa8b9bPwy1+Q/RfI8StCjAXfP4ljwROfN4X/rB6YpnILDQAf8qikxpp7tGJg0yll
         A9ua3Maklf1+bt573WkoGBDkaY634uIZLCPOre9sSpZ3y0bNzcVYCKtidlpSpk2ARY9m
         gAgL3Da9MaLptDF4+cd78yCgxcmswRivhXerEYHhe8OGMBmZyL6Mfpgl3AgLZjfL8MaE
         oNjyubR2p5IX6EvsZ5fQVd4bwcl6qbJpK6uY67wL5kSUOgUbs3GzeimPY2aaRjKFigVX
         J6W7j9u5lLV0+f1nZbBOxqb25xXG0Mum9RiUKiO+O9zZlo2oi/zPxDaRv1OeVa8pQ/x9
         +JPQ==
X-Gm-Message-State: AOJu0YwpqzKzpgHUP39Fsp1hSmY25ie0hDkOr8rZBuWhZn4i/hgIKYle
	FpeXZzhphNMD1C/7MrEswWF55w/fRhnNNVhH37xvVns5+46jLsP9qQkPcxFODgZg8w==
X-Gm-Gg: ATEYQzxWZAGwTnXAE3AdMKnaj59i8NspOFZaJebP+5OPCssBA/uekvhUwQft7Vy2X7G
	/KXyjqH+BgxxA1CvWI2yr2Hxmm0F7h9bOXDmacN40T99uzhI6y9O3g7zQWSHzK0nI/ISU8OBnKy
	l82twXH5AbK8G9aMZFn3I7U/gOBBmh9c9K1Apx1ClDGWBwnGpmjmMeUFp5CpJrEOmgI4m63nDMX
	hc2QG2yNSw5ZsRFR9dE8oUeggS4HOph0vA4GPUH+fMDbCl6IF/QbMBjTNGE7Ejy0W0yhKiqj9sP
	UaIN8C8BzA10bHr4PL/U1Hg3EHsxzgj927DSWseWXc3kCPIDJBnm80Gg2/e56XJSM2klH8LcwVz
	kqf3She30TvkS2lGnSA+xYFKqtsDLjhCLlRSlUAp20Ycgd1e5qK1wWtUpghw90u1bIDse6cIcga
	4GjkJrg8NGRE50P7hD
X-Received: by 2002:a17:902:d50e:b0:2b0:6df2:8cdb with SMTP id d9443c01a7336-2b06e21de42mr52463325ad.0.1773865837591;
        Wed, 18 Mar 2026 13:30:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:a:200:21ee:a76b:b098:63fe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e419b22sm39224235ad.11.2026.03.18.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:30:37 -0700 (PDT)
Date: Wed, 18 Mar 2026 21:30:26 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Message-ID: <absLYnREVR9ZNzxc@google.com>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>

On Wed, Mar 18, 2026 at 12:42:59PM -0700, Dave Hansen wrote:
> It might also be handy to have a:
> 
> #define X2APIC_LAST_MSR(r)	(X2APIC_MSR(x)+APIC_ISR_NR-1)
> 
> so that the resulting code is a bit more readable:
> 
> 	case X2APIC_MSR(APIC_IRR) ... X2APIC_LAST_MSR(APIC_IRR):
> 
> Dmytro, if you feel a burning need to respin this, don't let me stop
> you. I can probably just fix this up when it gets applied, or Isaku can
> make those changes and resend it too.

Sure, please feel free to take over this. I even have no way to test it
anyway. :)

I'm hesitating whether X2APIC_LAST_MSR would be the best name for it,
given that it is for ISR/IRR/TMR only and is using APIC_ISR_NR (so
maybe, don't know, X2APIC_LAST_ISR_MSR?).
