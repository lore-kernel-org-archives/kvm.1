Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD434D3B9;
	Mon,  8 Jun 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910082; cv=none; b=GR5Rn4L//kUzxiP4rOlhVos9avyLt1oXAD5hsSHxLVlKsFtPLJ+ars5TlOYa8QqKUnV0SbXUKavqLcDUnwQkr0pWMis0jhrVuxxChCUP/ANQGFRuHLOEwWlxdo1RGxDUu7hGhGjaHELa0tg878Yru9dWwDQhs9DuhQlELZpR3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910082; c=relaxed/simple;
	bh=zh3aOXv7FCsKLJFMPpQ3VMZ7R5Oct/WwClPT+tKR/dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC9FJaN/JmM2LqWqQR3eQvW2M4MRh8bdw8NmXuT1NfGvo0qGy2LuuqmGFVKUu9g/Yh7ts5z6HHubYhVwKgOacDXE8HASM/jXiv7/DTq9fY4dY9FypmIzY40MByW/GX/niLHOWU7ztYfQZDAJi97I6U931ODV07zpBN29IhJTXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVZfuFxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVZfuFxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D3C1F00898;
	Mon,  8 Jun 2026 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780910080;
	bh=w8WKGVREdZOOpGk0gbtvvLzYoxX8JwWSTpgeaYJ7wyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WVZfuFxzGYsoSVzDU7JQHqBL+HTFT5EeGJWDMv/LbjxDl/9rsOV9ZfagWMjjw608s
	 vCYGYwjS5+KuqwbZ8NfepE+wEXVY03BhRb+PmTP6Ur48E/gatwv6g7gos3tCxKcRls
	 +f9hoRGKnzrKnDRfWt6Kztoeg4om1fefMVuECQJ1aEKv03cdccSx/0R0rQH4qserAT
	 pTSvHrafXkXuBc9zizyrfcWyKvVRGGs4IOw1m5SGyX4VFnWzJqfVyHkdjvCZoMGcHK
	 aiIBvtSV5l13k9DfY6P1VBfP1Pi19jBVgBw7qjaSRfBUnvxv3II96d11s0xQdy9prM
	 GOKNw0OC48uEQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 713FFF40084;
	Mon,  8 Jun 2026 05:14:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 05:14:39 -0400
X-ME-Sender: <xms:_4cmajQs4cQla66AxF08vXsjqAsOXnvu0l2sTUmez5mUjPUbadrrAg>
    <xme:_4cmam3NWkksKdHdbxbH3r4JqlDTrS8K9uzGn4ImmHQX-wk9Oyl9OOKEMditapvdE
    QQvf1L2QOKcJ4D_XQU4ONjqSwx4GLQs_qP6CXobCjNa7v_nxmjXsw>
X-ME-Received: <xmr:_4cmam9rii96eEMtYr8U6NX5U3miTkzQCukUrVe1mlwnaxzOA-dYyV9_vnmP1A>
X-ME-Proxy-Cause: dmFkZTEpp2jBIHL1iG4u3SNtDTHsQFscovrVwxSBn9taEPDwJpp4yidpViy0S1I8sEq1aV
    dkoS3sx14WWowFfj66Z4+UiLOZvtZV+g0lPVmr3I/tcJZ20sHxWeY7OPeYkmoQ/18TsISI
    ZFWfJqR4dRUK5kAzGnR9gVGBOzl/HYQ8wVxMRaLGCWr9EqBEo8XlmMJw3jR7DHHEHNA+h6
    sYTuHHNrKi7O5d0uEO9xI4FSuuHfSyIz4UqMDrpzVo1k4SnqTCI51LOhHNUZB0uMchMtRz
    9fKgrh0U0MeyMFPZ8lQnj0c8k0j4R+K5AxxI2ycyHZQxi8fq2JPj4BtHhIe/f+y+O4TkTX
    Bguiwksmi+aWiBYPcZ121bwizEVrU7e0twY82LV7VVqWnPNfeZjSZNwXdM5FFnxOCZe/jw
    o4Aszsgs3UXqGhHRntrxQP+Zk7G5r+PC495LELFgSSmjYCE93Ml4MWxNLghCo5kbAF/xHR
    MJEoPYeC0n76WKTtvkhKwkShTVe+DaON12gcBYJ1HTS1aEQTNXT58eofn/o85nsOK0lg0a
    Oi7jleQiCru9iaHBdUi2R5Hdc/t98YW98a8hysMCBfTjiaArYf0Hj3p0alNavzcEJddO6h
    w9ZRmllRky61bpJVh8KoScWAMRTHtuMa8MCOloP3fZ2/S93/UJscokAxk+EA
X-ME-Proxy: <xmx:_4cman_snpJ-z0htfCY8nKeL78s0352ucCV07XZ0CjPpb1GWGKfLGA>
    <xmx:_4cmapEpS_g94OjBuMSwu4KXsMRDF9zXA1RVeW7ksgooUxtFAw2V7w>
    <xmx:_4cmahf7KCLdSQytLM2zu8zGy0OndWRJuVI2JhiVIM-2b-Jl1RIvjw>
    <xmx:_4cmaokkfuynI7ORIBjoNHv9Of1GT7FxUJuuiJ9x1Obpr17Czc1rwQ>
    <xmx:_4cmajoj95HHMjzAhL06tyvPYpCfGxQFvkEoKuQvviDeOBYL7Y6512Mz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 05:14:38 -0400 (EDT)
Date: Mon, 8 Jun 2026 10:14:33 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"bp@alien8.de" <bp@alien8.de>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <aiaGUD0B1Vtx_PlN@thinkstation>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
 <ahVghgNAe4JrmlQH@intel.com>
 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
 <aiGq7XjmMrsqdBY5@thinkstation>
 <aiJhScChLZkH44eB@intel.com>
 <aiK1_q8beMcIEiwO@thinkstation>
 <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>

On Fri, Jun 05, 2026 at 09:23:21AM -0700, Dave Hansen wrote:
> On 6/5/26 04:42, Kiryl Shutsemau wrote:
> >>> I don't see a reason why we can't keep the scoped_guard() on get side.
> >> One additional reason to drop scoped_guard() is that it mixes cleanup helpers
> >> with goto, which is discouraged. See [*]
> >>
> >>  :Lastly, given that the benefit of cleanup helpers is removal of “goto”, and
> >>  :that the “goto” statement can jump between scopes, the expectation is that
> >>  :usage of “goto” and cleanup helpers is never mixed in the same function.
> > Fair enough.
> > 
> > But it can also be address if we free the PAMT page array with the guard
> > too :P
> 
> How important is this patch? I see "Optimize" but I read "Optional".
> 
> If we're arguing about it, maybe we should just kick it out and focus on
> the more important bits.

I don't think it is optional for anything outside of test setup.

Without the optimization, we have all KVM memory allocations serialized
on a single spinlock. And we do alloc_pamt_array()/free_pamt_array() all
the time too.

And since the lock is global, it is an easy DoS attack vector: one guest
can do a shared->private->shared conversion loop and make every guest on
the host suffer.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
