Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25173382F19
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390733; cv=pass; b=iXqUqlAmQwkRqfu4CiErbwQKdyxUyz+9dxzPtVyN3AdJSHaUpV4yN263qYr/p3dyOGDnhX2C+sMMyYNY9J4IiJ8AzEu4mdwn0bOJXfuGh20nvlCKEyxIb/EXu+315pP9rsXflFsC1hmEO7BsYkiEgpq66Z54itZmV0M6Ylb3Txs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390733; c=relaxed/simple;
	bh=73CFgCEKHFJELY9UP5/RhebVFajDLrcQrE0lsXPbdIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2YbTeYjV9XBo3Nh81hhasHFf3BdU2Om53Phg1Dh6w/pXZ2Eq/XhRBFldkoYClgvIgbyzyKe50DI6prhbNSzYggQGYL4HSgT/Q0WaBtsgM7yzLwA4NrsnxcZ9as05YOAX9xsPaw9x8vZTufoeC8a44YTu5c0ltASeK45V1oqcMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQJMmXtD; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQJMmXtD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509062d829dso332541cf.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 01:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773390731; cv=none;
        d=google.com; s=arc-20240605;
        b=PvwGplhcRP7SdoyFWeGebDZxUJUZKP3wEobPKFQ+7+JpAcRwFjJxxCZQW0m/kabP+T
         ssmpps14F9VmuytlO2YX4PFAjRj6wrX9zJOoctr0yeCOyDWTB6KOhuO+62Dxs7vdB90b
         PweO162km+sQJ1LM0+EFBrondoOZDhLbMF3gKmhozvk4SB8y0ybYykSetdGeIz6G0jkW
         dUBUzGLDjs6hdwr4mS95bcVzCOPZy02VJPQgIM9/oN4Ypuy2pWahnBHcbpB9bWqFYdfX
         xJhm42v680fTaDc0NreN3IiSdVyMQ+ja6vveZ/8wNaAZTF8e8rm8a2SqAiBLTmXiDPjK
         B3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+ZginHenLFfV4BXN5/Mah3uAKtVZ/csIYirzOzG2w24=;
        fh=T6M41bVExPjve5tJBT0rVW3iUc7VhpgTX8CeBcvjELg=;
        b=QaRoqhNAwkxXxE6GyXOXQWnAjphE/KpLYIdyvMvsGXMo0gfUN0aunPCOxMrDYAwBX3
         zNdPwhWh66Pq4of8BTR/fix+esL20CNHz9h7CmFL3HBTgm9jJrRg97hdr623ZJhE5rUa
         kGgVBsCF9oCYnjKBhXGCcc+OZYUxseVh74BEy7E/5ttq/rmpIeQgOA1MoEnaypXH9xCR
         S6U7VWVqvmbxt1i9cnWV5LQTq4bIYG4duxPZU9dhFswVvy8l0NIpyQgqD0VxtUgce6+z
         jWSbr+5yWhy6q70HpH6/F5IGsnQYs8OBUu2HDAwbLiQK3SOtkmaS8Vqgvh6dVvNNI1Mj
         m5SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773390731; x=1773995531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZginHenLFfV4BXN5/Mah3uAKtVZ/csIYirzOzG2w24=;
        b=nQJMmXtDeSbfqyR+LkB3F6MP0abezHJlWnsMbWoEcXY08iHzHCjQhwLMn8VR4iT2Be
         G1UgMm5hGMR3gYMYgmgkeR25dFtszddTUZNA8KbWejU6Qg0bU6y5QU4ORGPkXuJSWgdL
         qF0bNUYpsGBcQsDCD9VCFAx8lIRtDxgdSh9W9HQrqGJFElIOD/TzbthIFloS0wM57u0Z
         quzVdUomwO1CWThAvGKXHVUhtRBgezKzUsbQRN2pRl9u8QU58pk9XVuVvuJUsevLO37B
         /2oUkr+FqlOR2zNGSgeYYq3id7E/zCJFtLM+z9d6ojL5T/PvKBMvtY9I0pHKEDDVyg/a
         +l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773390731; x=1773995531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZginHenLFfV4BXN5/Mah3uAKtVZ/csIYirzOzG2w24=;
        b=jFpin+yPCl9qjosNZAmmsLtIhK9f73oR2fiXYKfBXK55kNf3JD3S6t343e2b6mLQXV
         jhFdwqL1eGpraJ/6zza/D4kdT0FNysUhoRPo7HtU2zMAxS9gMgRqDSCl4hAtTPtmqnJa
         hMiQJ6UK+nU+venbtsymEGxylW1/z7g//8HSNzuVBHOrCWPg7ndjhOxU2A/bArERQfqE
         WAlA6jtWkuaBDwz9ZT2qlW1LE19KKgP7m/zhdoqS2SLfLrQQT38RQgFOCcRGbKAY2c5S
         Qx7eJzRSspIrn9ZOy3Fc1o5MKqutx6mpXFdI/i4WVNtOuk8Z1jwOcgAlU1hfkiUzvGdT
         gtFg==
X-Forwarded-Encrypted: i=1; AJvYcCWJrQMYtCfs9HkO4Q5cCiPz4XGk4vTsZxLI/T5lz8wExYsMB1lhVax+I28sIyVd5wUpLy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCuwUkNKSrhwlV6zKKsAqYvGJtwyWbjtJHzTqsNilt2xBVcin
	ErucWDfmxwJidRJTELv+ELKkDVxH/e+9cGkJIQeaCb01N0sd928auXsXcZH0qJfvAg1CRanb1Rb
	wXLUt2/MKUSuAwEvdQ8eAusqkcY8KeMhRNnd8ELC1
X-Gm-Gg: ATEYQzxrsUYK8Vzt7GH0u4OZvSj8bz5gdgVSwsWHcpa55Iawr3OoDB1HiP/8E5nsu+h
	g0An+KLp2r5mEsjYE1oGttVhwmy6SdxBAETv3cP7jPuXXhOdCwSaREd/V8mn9SPtP+VCb9k1ouR
	8tay+Oy3dIsBfc7mgsw3siToLvgKXKeMvTeQeaLMgHGyFI5dlLcoiM48FjstgwkNRuHE5sApA8e
	Q18pXsTj9kROkHsDYqZGo3HTu9Fy3b3NpCCbN1qkEhZkNN6P0F2mxIJcDVvH9KICfWBCl2VJ6XB
	KC1No2lB
X-Received: by 2002:a05:622a:58c:b0:506:9852:75ec with SMTP id
 d75a77b69052e-50959e1d20cmr8206111cf.9.1773390730313; Fri, 13 Mar 2026
 01:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
 <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
 <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com>
 <abLfWHf89TxWqeGZ@google.com> <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
In-Reply-To: <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 13 Mar 2026 08:31:33 +0000
X-Gm-Features: AaiRm52mXTtSsie7DL9lVs7x2V-5c-a3ZmVbxJyJb1VBocy3h5inh1iSGtq73Is
Message-ID: <CA+EHjTzJmJZF=XE2NWsTZ9yCVix8oLp6M_Jb5m2EuC-W5p+U4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@kernel.org, hpa@zytor.com, ira.weiny@intel.com, jgg@nvidia.com, 
	jmattson@google.com, jroedel@suse.de, jthoughton@google.com, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, shivankg@amd.com, shuah@kernel.org, steven.price@arm.com, 
	tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

<snip>

> > By default, KVM makes no guarantees about the in-memory values after memory is
> > convert to/from shared/private.  Optionally, userspace may instruct KVM to
> > ensure the contents of memory are zeroed or preserved, e.g. to enable in-place
> > sharing of data, or as an optimization to avoid having to re-zero memory when
> > the trusted entity guarantees the memory will be zeroed after conversion.
> >
>
> How about:
>
> or as an optimization to avoid having to re-zero memory when userspace
> could have relied on the trusted entity to guarantee the memory will be
> zeroed as part of the entire conversion process.
>
> > The behaviors supported by a given KVM instance can be queried via <cap>.  If
>
> I started with some implementation and was questioning the value of a
> CAP. It seems like there won't be anything dynamic about this?

We can drop the CAP for now. Probing via the ioctl and handling
-EOPNOTSUPP is entirely sufficient for the VMM to discover whether
ZERO or PRESERVE are supported for a given architecture and conversion
direction.

> The userspace code can check what platform it is running on, and then
> decide ZERO or PRESERVE based on the platform:
>
> If the VM is running on TDX, it would want to specify ZERO all the
> time. If the VM were running on pKVM it would want to specify PRESERVE
> if it wants to enable in-place sharing, and ZERO if it wants to zero the
> memory.
>
> If someday TDX supports PRESERVE, then there's room for discovery of
> which algorithm to choose when running the guest. Perhaps that's when
> the CAP should be introduced?
>
> > the requested behavior is an unsupported, KVM will return -EOPNOTSUPP and
> > reject the conversion request.  Note!  The "ZERO" request is only support for
> > private to shared conversion!

I think that this makes sensefor the UAPI. Returning -EOPNOTSUPP for
shared-to-private ZERO conversions.

For pKVM's specific use cases where the VMM requires a zeroed page to
be injected into the guest's private space via attribute conversion,
the VMM can simply `memset()` the shared memory to zero in userspace,
and then invoke the ioctl with the
`KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE` flag. This completely offloads
the UAPI from making guarantees on behalf of the trusted entity, while
still satisfying pKVM's functional requirements.

Cheers,
/fuad
