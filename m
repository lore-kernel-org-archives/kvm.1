Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616188;
	b=Nx6i37uG9iJNB8Yv+365/W2JjZqnydJTHWHbcdw7iiRfm84dWw90HBQZobPOXTce3Pgp
	 IGbHr8mIfdgDIsgAeHBN+CWRyVJK0Cd2zR5dUH2wBm3NUa1JBMynbMPoF/9FVCCcA6x4w
	 e2g6AiuCtlvD1g66TECvqKFcIob/AC0N4qBeiwMfo71amOTJpA/4nVH+mcZLV02DYaWcc
	 bkK8KZjAcCTViJHiA4ZruBv2bVFpz1sqLCthcTx40tg96pTGsUTdIjL7zLv75w0KsxrwC
	 lspsz8kNVkeppmT+KbEDOettK1K9nZDnAMpK0M3ITQICoXv9A9dex3RlEu2X+l76ePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i/jrBB7rLlSUxUEPdi3kz4rjRXIQytYo5vvcwBrT/JI=;
	b=zDlf50m/kke9YuZt/pZttAqQjKHl4WC7u8mmqOoKTNGgaMSzobq92Tx4qNYHeXLcyTUm
	 baLX9CZWnz9qNBgJd75+z6yuMzJAxAZdXR6O+uLO4byKGCJSY9fVIyGnDWNR4TS1DFagi
	 sEzzAfy3MmAzl6B8WJ2ZYwJ26ZUG2//4qipQqaGxh6/VTDfJP78sfJtqkZkKo8mcqdSCW
	 MM8JDBwN1zsf921GDgIssLHNsmFzGPin5HwRHAvep/EjCzg/Mk+QRDzfWkDN9f5My5TWF
	 wSpJOrfeSycO5pe3Clj5okQsdsTa6dBDFpgXVNe1pvkGcHS4ZKxyOxwixOSms/v535A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VYfWFNA2;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B05606A327
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B05606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VYfWFNA2
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9217800e7f3so11202456d6.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616186; x=1796220986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i/jrBB7rLlSUxUEPdi3kz4rjRXIQytYo5vvcwBrT/JI=;
        b=VYfWFNA2L/Cja4VLPPODTcDvNUqUKXBieR9yY5ZpA9+jcmW6L7WOvtr9YY29MeQWOm
         1lXZzMQuwnpxWRgETtqd35EdSCURdPyffthqpG41RzuMhCGg9V4w+QBIjdSRq1vBQoms
         xLWCdmNr+35Zp51Poed52PWFdsyKoVJbRTkz4kpLgjstuWMiR52L26JdkFjs9RsxXQYc
         NA0XtsU+IEOmtnLjEo7nqedYGkO/gPohBvneg8rx4uVhQadTAfSwYuShJ0umvcLNKaob
         XpFVOJTr9x+iQATEYALHyc4ka5lR2xaCRGX7H6dSiOfaC8AFMWamJCHcz0E3W5RhKqdU
         v6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616186; x=1796220986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/jrBB7rLlSUxUEPdi3kz4rjRXIQytYo5vvcwBrT/JI=;
        b=bqHcXxkMxN7KclYnyHmhhvVPBXXnL8rXdSDjQiSfJb3yadQ64N/f/9qHxdoxVcNyHP
         L1sW8FOH7eFcX6W0DBn4RpqX7SoT69uWfs05EDinTJ4SFXW5Z3Ofwpd+TszK/D0IW6kK
         +DQ4Je7zBrAGnl5+FSNMkDmhOJ5UlaVdqNQGhuNrKH5WC9GzQWIOluZLbsUg2rcrTB8y
         +703LH5YJhkHIoxX1IFLyLiAhMxmIJTzd+qnJN/Jn+a+WsMBBgg488MpYgtuXXNd0KE4
         xdLsYwbjGuNwTAA9bAp8FHPfEUzVCuOFERlFakVIdt4CPDqAbmKjaBIuOn7HA2jkGk8V
         XkZQ==
X-Forwarded-Encrypted: i=1; AL+hErG8edFAuqI4TKlCkbrFhdWaH0sRs95g+USQD5uZu6FSJObjF7qC4wzV2GKe2K3Q4AtmAEY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+njh44RwXdp3VQI86ljFaoifqMTXE6FI0LoEjzeBCGwQG67Fp+
	XdcMmU/tyIS5P+o3wVBIp0Fsr9l6dBMca35P/faujzTvOD+IIP5PlAH/pv4DXZX5agU=
X-Gm-Gg: AZFdTZdMZDE/xolyXdFhj3p0f5ViSBCWnNh5h5ukvhri30ltQ5Xes0BzvR5VJ0R9qy9
	+9byOJjO7P1iKFsY/4zztSRn4sxtuYeQWiFzPuGtec5zG1Jv36rPbZ1SCJomBsr0B2z6iK+3CFB
	yjvLNnZjgD45zEuy6f4MG8TuGLP2ygtyZvoukJNnw3Zj/QpJNjCwzwABn5Dm7N8dijQWjgM1Okp
	WeAJmAqse8ST9ZAUKahTCkwNA0JPf3sceGEP2qvjOYiJCLsbuJUOGawDDx2XNqP+3GeMtRzTvTr
	Wy6RWaP+4wBMflpFHPRCg8fBAd4e8aoLU5pY9DAX9aNwaIvYUzRHQx6Tyqzs3YBkz/k7tbBZ64a
	JOKEvOaJSxJATnQTWem0gkI8QbW2mmsrnZsuaSQn0Rp3HmM0Izab3/X3wD3iZ4eFneFFVJC+sgp
	7QhmotC9dA9cmwIlxrI0eRlIF+Mkuw8oMcZclOjnImnwkt1dFi29IVeiks6fU8GqUFidb0Fje94
	Ku21qlpIbuIBeL2FpxIhHa9ZFAhCp7u7Omv4YVp4+VhF4xXNg8PbEqYhrtLvZiw8vCPjTRlI76x
	OutQ3n/3tQFOih4Y0GSVhot6OOQ=
X-Received: by 2002:a05:6214:2f08:b0:921:5102:6b02 with SMTP id 6a1803df08f44-92151026b60mr217389976d6.38.1795616186267;
        Wed, 25 Nov 2026 06:16:26 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9217fd18b2asm6696336d6.21.2026.11.25.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:16:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDnN-00000001jAp-0WzE;
	Wed, 25 Nov 2026 10:16:25 -0400
Date: Wed, 25 Nov 2026 10:16:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 01/10] PCI/TSM: Report active IDE streams per host
 bridge
Message-ID: <20261125141625.GA246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-2-aneesh.kumar@kernel.org>
 <f377271d-353f-4c8e-94d5-98159a66ab28@amd.com>
 <20261124024842.GB9566@ziepe.ca>
 <yq5azeux9xxm.fsf@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azeux9xxm.fsf@kernel.org>

On Wed, Nov 25, 2026 at 12:53:33PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Nov 24, 2026 at 11:11:49AM +1100, Alexey Kardashevskiy wrote:
> >> On 23/11/26 19:33, Aneesh Kumar K.V (Arm) wrote:
> >> > From: Dan Williams <dan.j.williams@intel.com>
> >> > 
> >> > The first attempt at an ABI for this failed to account for naming
> >> > collisions across host bridges:
> >> > 
> >> > Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> >> > 
> >> > Revive this ABI with a per host bridge link that appears at first stream
> >> > creation for a given host bridge and disappears after the last stream is
> >> > removed.
> >> > 
> >> > For systems with many host bridge objects it allows:
> >> > 
> >> >      ls /sys/class/tsm/tsmN/pci*/stream*
> >> > 
> >> > ...to find all the host bridges with active streams without first iterating
> >> > over all host bridges. Yilun notes that is handy to have this short cut [1]
> >> > and from an administrator perspective it helps with inventory for
> >> > constrained stream resources.
> >> > 
> >> > Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> >> > Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> > ---
> >> >   Documentation/ABI/testing/sysfs-class-tsm | 13 ++++
> >> >   drivers/pci/ide.c                         |  4 +
> >> >   drivers/virt/coco/tsm-core.c              | 95 +++++++++++++++++++++++
> >> 
> >> I'll take to the tsm tree, thanks!
> >
> > Lets not take any new sysfs APIs please. These all need a careful
> > thing and we are not having a good history right now on any of these.
> >
> > I'm not even sure what this is supposed to be for, is it debugging?
> 
> 
> I think this helps users identify active IDE streams and determine how
> many secure streams remain available on the host bridge. I would not
> classify it as a debugging-only aid.

It looks like debugging to me..

> A sample output for a toplogy given below
> # lspci -t   
> -[0000:00]-+-01.0-[01]--+-00.0
>            |            \-00.1
>            +-02.0-[02]----00.0
>            \-03.0-[03]----00.0
> # 
> 
> # pwd
> /sys/class/tsm/tsm0/pci0000:00
> # ls
> 0000:00:01.0  0000:00:03.0              pci_bus  stream0.0.0  trust_policy
> 0000:00:02.0  available_secure_streams  power    trust        uevent
> # cat available_secure_streams 
> 255
> # ls -al stream0.0.0
> lrwxrwxrwx 1 root root 0 Jan  1 00:48 stream0.0.0 -> 0000:00:02.0/0000:02:00.0
> # 
> 
> Here, I have set up an IDE stream with 0000:02:00.0.
.
> The previous discussion cited in the cover letter indicated a need for
> this because the number of streams available at the host bridge level is
> limited.

So explain how the imagined "systemd device acceptd" is supposed to
use this automatically?

Explain how it works with the future need for a more complex P2P
scenario

Explain how it works inside a guest to accept IDE streams setup by the
host.

IMHO we are no where near understanding streams well enough to have a
uAPI implementation, nor it is even clear sysfs will be enough to get
us what is needed for everything.

I would prefer we focus on the things we are starting have a consensus
on, there are so many right now, lets try to get them merged before
opening up even more topics.

Jason
