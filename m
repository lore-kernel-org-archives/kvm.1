Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477450;
	b=p1mVHHP+W5PWV+ICm4UM0YzxZV18DlEnX1wtf2jc6IMA+wyzi2AdpzWtjX6XPqil3XJ7
	 5h933+nBiEV5GLeP15LmxlYFq53fCax4B9EBUqWHAT1pS85t27+C9Hawh9WtnCLMc8mDi
	 ku+pWxV2mByxiDhU0kQCFbtsXMNSPJIO7fPs7Heg3QnM8I+nwV1vThPY/A63T/b4Rflbc
	 UfTKhK+PxYTZR15yGGDGWIJ60gL+csaW0hWJFT9GFqxNjap7nPcRJqzvL1Nug71zz8SdV
	 9BU3PhysG5m9Mzq1JiPZoS3btGiibq6kY7aGp0/VdGhjH2KubsxUmo0UqTsBsfQ64bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477450;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mBtESuHy2E6hmhH9gCEAEGvYKiyNseWHpeyA5Das+jg=;
	b=Z/qpCPZjDuFE7hmq0UwyNPpZ/uR4Wm9GjkcSYhW8RXXm5jx/WPKvjZn9VsbxlNE4tRyQ
	 K2aIAhwEsYpCKRNvH1W5/ehczJaJ5wtyUCGIIhymE7dM9HxnWfyE/gW/THBEyxGGN1mWp
	 MnDOBvGViHQvTAoYbv7CpsqYHaHLG4tjYtoggmlflrweEIwc00GonGfh6CAEo4rqw+7Gf
	 zd6J4tqzxdNutYwTvTJxKOlxTrbjsGutrpJb94UAsnQuOBYZp6CaMtD9eHfFsZtt9UJfv
	 mgoFhUjqZkJrXzJL3N655sIrSA3Qqsfvms3bF3agFbeEHlxzOgMp3Yg/jHbBmhm3GOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ZwndQHer;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DAF606A335;
	Mon, 23 Nov 2026 23:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15DAF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ZwndQHer
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99B8540E02B4;
	Mon, 23 Nov 2026 23:44:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TAZ-fo3_TgdT; Mon, 23 Nov 2026 23:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795477436; bh=mBtESuHy2E6hmhH9gCEAEGvYKiyNseWHpeyA5Das+jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwndQHergXv9ll89e2tJKfQsAHhhnS7Z0JK44STFAquQAeYZoYWL2zJFtaOGveUMg
	 7RigD5Emuntn5ccm1Is+yMEPUzUEsDh88GAw5TQ9uW+6uXCRR57cmDAfRtVBkv9jDm
	 nT2OHMT31JFAywrgEF/a988nsS7BKxMNRGtN88aU8iw9J381ht9s3k/VRpfy9SiF90
	 S9+nrC8f0vaGScOCxUAsZvJUGFNA2z8wY5b62Gi8L7KNjQ2VtMyNFjXMkg8peTqM9q
	 abECEMw60dpbEObt9yed+zlBS8Sx/QzSZ4UDCTA7g+sQyn08O5Rk+XPqiIVOwWQ9NW
	 LCaNcefSG1RCsTpD4i5fU/zo7DuNuZMqLAwwaJuPh0LGUxIvlp9t/jr0pdyd/2xw9G
	 PCfqEv418uFr/VF4pn66jWjvPEb3MeHJ5rQYhr9eJ4INS1LTQZxq0Huw+pIaB62aXG
	 K2FcLZI8CmYaDGl+hO6sBwvh59rJ/HvNt9d3SxSW38m10jOxCPaGe4+t6mQdjkcfYA
	 PpbBLAAiTxokRFKpDYP9C+O6ZOdB1V5oszNH/EFi3mAsJELjLVHMe72LiPJKAebACh
	 w6jj1B1aauMb0oe9tC7DLu35jQ8/7iBO/XPzhOqnX5nwCEkq8GSfOsnBGJ8U3xx+0J
	 O0VuUDPgFmIUuYrr1S2vonmg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39CA540E0240;
	Mon, 23 Nov 2026 23:43:44 +0000 (UTC)
Date: Mon, 23 Nov 2026 15:43:41 -0800
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>, nikunj@amd.com
Cc: tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, thomas.lendacky@amd.com,
	Srikanth.Aithal@amd.com, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
Message-ID: <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116230335.1161521-1-Ashish.Kalra@amd.com>

On Mon, Nov 16, 2026 at 11:03:35PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
> SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
> intercepted and delivered to the guest as a #VC exception, which must be
> serviced through the GHCB.
> 
> By the time machine_kexec() runs, snp_kexec_finish() (called from
> native_machine_shutdown()) has already converted the per-CPU GHCBs and
> the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
> GHCB infrastructure. The DR7 write therefore raises a #VC that
> dereferences a NULL GHCB pointer, causing a page fault and the kexec to
> fail.
> 
> The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
> Fix early boot failures on SEV-ES/SNP guests"): that change makes
> __sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
> the previously-benign teardown-window #VC (a bogus VMGEXIT the host
> rejected but survived) into a NULL dereference.

So, before that patch from Nikunj, __sev_get_ghcb() would return the per-CPU
GHCBs which are not initialized. That was fine for the kexec case - I don't
understand the bogus VMGEXIT thing - but apparently it worked there.

For Nikunj, though, that didn't work because FRED can't have early #VCs with
those uninitialized GHCBs so he falls back to the boot_ghcb.

Now, however, boot_ghcb is already cleared and DR7 writes cause #VCs.

So something about the lifetime of those things is still not good enough.

So it looks like this, AFAICT:

---
                cpu_hotplug_enable();
                pr_notice("Starting new kernel\n");
                machine_shutdown();			<--- destroy GHCBs
        }
        
        kmsg_dump(KMSG_DUMP_SHUTDOWN);
        machine_kexec(kexec_image);			<--- DR7 write needing a GHCB
---

And snp_kexec_finish() does this:

        /*
         * Switch to using the MSR protocol to change per-CPU GHCBs to
         * private. All the per-CPU GHCBs have been switched back to private,
         * so can't do any more GHCB calls to the hypervisor beyond this point
         * until the kexec'ed kernel starts running.
         */
        boot_ghcb = NULL;
        sev_cfg.ghcbs_initialized = false;

So here we've switched to the MSR protocol.

And the MSR protocol is supposed to be valid at any time, exactly for cases
like that.

And we do have a rudimentary do_vc_no_ghcb() for when no GHCB has been
configured yet. After all, that's the point of the MSR protocol, no?

So, long story short, how about switching to that no_ghcb #VC handler instead
and dealing with the DR7 VC exception that way and actually using that MSR
protocol for what it has been designed?

Instead of piling more cards on the already unstable house of cards?

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
